import EventKit
import Foundation

// Read-only calendar query tool
// Usage: swift calendar_query.swift [days_back] [days_forward] [calendar_name]
// Example: swift calendar_query.swift 7 0 "akushch@twilio.com"

struct Event: Codable {
    let title: String
    let start: String
    let end: String
    let location: String?
    let attendees: [Attendee]
    let organizer: String?
    let isAllDay: Bool
}

struct Attendee: Codable {
    let name: String
    let email: String
    let status: String
}

let args = CommandLine.arguments
let daysBack = Int(args.count > 1 ? args[1] : "7") ?? 7
let daysForward = Int(args.count > 2 ? args[2] : "0") ?? 0
let calendarName = args.count > 3 ? args[3] : "akushch@twilio.com"
// Comma-separated internal domains to exclude; events with only internal attendees are filtered out
let internalDomains = (args.count > 4 ? args[4] : "twilio.com")
    .split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

let store = EKEventStore()
let sema = DispatchSemaphore(value: 0)

let isoFormatter = ISO8601DateFormatter()

store.requestFullAccessToEvents { granted, error in
    guard granted else {
        let msg = ["error": "Calendar access denied: \(error?.localizedDescription ?? "unknown")"]
        print(try! String(data: JSONEncoder().encode(msg), encoding: .utf8)!)
        sema.signal()
        return
    }

    // Find the target calendar
    let calendars = store.calendars(for: .event).filter { $0.title == calendarName }
    guard !calendars.isEmpty else {
        let msg = ["error": "Calendar '\(calendarName)' not found. Available: \(store.calendars(for: .event).map { $0.title }.joined(separator: ", "))"]
        print(try! String(data: JSONEncoder().encode(msg), encoding: .utf8)!)
        sema.signal()
        return
    }

    let now = Date()
    let startDate = Calendar.current.date(byAdding: .day, value: -daysBack, to: now)!
    let endDate = Calendar.current.date(byAdding: .day, value: daysForward + 1, to: now)!

    let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
    let ekEvents = store.events(matching: predicate).sorted { $0.startDate < $1.startDate }

    let events = ekEvents.map { ev -> Event in
        let attendees = (ev.attendees ?? []).compactMap { participant -> Attendee? in
            guard participant.participantType == .person else { return nil }
            let email = participant.url.absoluteString.replacingOccurrences(of: "mailto:", with: "")
            let status: String
            switch participant.participantStatus {
            case .accepted: status = "accepted"
            case .declined: status = "declined"
            case .tentative: status = "tentative"
            case .pending: status = "pending"
            default: status = "unknown"
            }
            return Attendee(name: participant.name ?? email, email: email, status: status)
        }

        let organizer = ev.organizer.map {
            "\($0.name ?? "") <\($0.url.absoluteString.replacingOccurrences(of: "mailto:", with: ""))>"
        }

        return Event(
            title: ev.title ?? "(no title)",
            start: isoFormatter.string(from: ev.startDate),
            end: isoFormatter.string(from: ev.endDate),
            location: ev.location,
            attendees: attendees,
            organizer: organizer,
            isAllDay: ev.isAllDay
        )
    }

    // Keep only events that have at least one attendee from outside internal domains
    let filtered = events.filter { event in
        guard !event.attendees.isEmpty else { return false }
        return event.attendees.contains { attendee in
            let domain = attendee.email.split(separator: "@").last.map(String.init) ?? ""
            return !internalDomains.contains(domain)
        }
    }

    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    print(try! String(data: encoder.encode(filtered), encoding: .utf8)!)
    sema.signal()
}

sema.wait()
