-- Search Apple Mail for emails from a specific sender with date filtering
-- Usage: osascript search_mail.applescript "sender_name_or_email" [days_back]
-- days_back: number of days to search back from now (default: 30)

on run argv
    if (count of argv) < 1 then
        return "Error: Please provide sender name or email as argument"
    end if

    set searchTerm to item 1 of argv

    -- Default to last 30 days
    set daysBack to 30
    if (count of argv) >= 2 then
        set daysBack to item 2 of argv as number
    end if

    -- Calculate start date
    set now to current date
    set startDate to now - (daysBack * days)

    tell application "Mail"
        -- Search inbox for messages from sender (much faster than looping)
        set inboxMessages to (messages of inbox whose sender contains searchTerm and date received ≥ startDate)

        if (count of inboxMessages) is 0 then
            return "No emails found from: " & searchTerm & " (last " & daysBack & " days)"
        else
            -- Get the most recent one (Mail returns them sorted by date, newest first)
            set theMessage to item 1 of inboxMessages
            set msgSubject to subject of theMessage
            set msgSender to sender of theMessage
            set msgContent to content of theMessage
            set msgDate to date received of theMessage

            return "Subject: " & msgSubject & return & "From: " & msgSender & return & "Date: " & msgDate & return & return & msgContent
        end if
    end tell
end run
