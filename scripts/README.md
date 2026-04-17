# Scripts

## search_mail.applescript

Searches Apple Mail for emails from a specific sender with date filtering.

**Usage:**
```bash
osascript scripts/search_mail.applescript "sender_name_or_email" [days_back]
```

**Parameters:**
- `sender_name_or_email`: Sender name or email to search for
- `days_back`: Number of days to search back from now (default: 30)

**Examples:**
```bash
# Search by name (default: last 30 days)
osascript scripts/search_mail.applescript "John Doe"

# Search for emails from today only (0 days back)
osascript scripts/search_mail.applescript "customer@example.com" 0

# Search for emails from last 7 days
osascript scripts/search_mail.applescript "Jane Smith" 7
```

**Note:**
Claude automatically translates natural language date ranges ("today", "yesterday", "this week") into the number of days to pass to this script.

**Returns:**
- Subject, From, Date, and full email content (including thread history)
- "No emails found" if no matches

**Note:**
This script is used by Claude to automatically search your Apple Mail when you ask to find customer emails.
