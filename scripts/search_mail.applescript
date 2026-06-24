-- Search Apple Mail intelligently by sender OR subject with date filtering
-- Usage: osascript search_mail.applescript "search_term" [days_back]
-- Auto-detects: if search_term contains @ or looks like name -> search sender
--               otherwise -> search subject

on run argv
    if (count of argv) < 1 then
        return "Error: Please provide search term as argument"
    end if

    set searchTerm to item 1 of argv

    -- Default to last 30 days
    set daysBack to 30
    if (count of argv) >= 2 then
        set daysBack to item 2 of argv as number
    end if

    -- Auto-detect search type:
    -- If contains @ or is short (likely a name), search by sender
    -- Otherwise search by subject
    set searchBySender to false
    if searchTerm contains "@" then
        set searchBySender to true
    else if (count of words of searchTerm) ≤ 2 then
        -- Short queries (1-2 words) are likely names
        set searchBySender to true
    end if

    -- Calculate start date
    set now to current date
    set startDate to now - (daysBack * days)

    tell application "Mail"
        -- Search based on detected type
        if searchBySender then
            set inboxMessages to (messages of inbox whose sender contains searchTerm and date received ≥ startDate)
        else
            set inboxMessages to (messages of inbox whose subject contains searchTerm and date received ≥ startDate)
        end if

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
