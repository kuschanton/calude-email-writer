# Scripts

## copy_to_clipboard.sh

Copies the content of a file to the clipboard using input redirection (most reliable method).

**Usage:**
```bash
./scripts/copy_to_clipboard.sh path/to/file.md
```

**Used for:** Copying email drafts from history directories to clipboard.

---

## fetch_help_article.js

Fetches and extracts clean content from Twilio Help Center articles (help.twilio.com).

**Usage:**
```bash
node ./scripts/fetch_help_article.js "https://help.twilio.com/articles/ARTICLE_ID"
```

**Returns:** JSON with title, clean content, and URL.

**Used for:** Extracting content from help.twilio.com pages when WebFetch doesn't work well on JavaScript-heavy pages.

---

## google_cse_ui.js

Searches using Google Custom Search Engine (requires GOOGLE_CSE_ID in .env).

**Usage:**
```bash
node ./scripts/google_cse_ui.js "search query"
```

**Returns:** JSON array with search results (title, url, snippet).

**Used for:** Web searches to find Twilio documentation URLs.

**Requirements:**
- GOOGLE_CSE_ID environment variable set in .env
- Puppeteer installed (npm package)

---

## search_mail.applescript

Searches Apple Mail for emails from a specific sender with date filtering.

**Usage:**
```bash
osascript ./scripts/search_mail.applescript "sender_name_or_email" [days_back]
```

**Parameters:**
- `sender_name_or_email`: Sender name or email to search for
- `days_back`: Number of days to search back from now (default: 30)

**Examples:**
```bash
# Search by name (default: last 30 days)
osascript ./scripts/search_mail.applescript "John Doe"

# Search for emails from today only (1 day back)
osascript ./scripts/search_mail.applescript "customer@example.com" 1

# Search for emails from last 7 days
osascript ./scripts/search_mail.applescript "Jane Smith" 7
```

**Returns:**
- Subject, From, Date, and full email content (including thread history)
- "No emails found" if no matches

**Note:** The script searches by sender (from address or name in thread). Claude automatically translates natural language date ranges ("today", "yesterday", "this week") into the number of days to pass to this script.

---

## fetch_ombud_article.js

**⚠️ NOT TESTED YET - Work in Progress**

Fetches Ombud search results with authentication. Designed to automatically expand results that have responses (skipping "No text responses" entries).

**Setup:**

1. Export cookies first (one-time setup):
```bash
node ./scripts/export_ombud_cookies.js ombud_cookies.json
```
This opens a browser, you login to Ombud, press Enter, and it saves authentication cookies.

2. Use the cookies to fetch search results:
```bash
node ./scripts/fetch_ombud_article.js "https://app.ombud.com/rx/.../search?q=QUERY" ombud_cookies.json
```

**Search URL format:**
```
https://app.ombud.com/rx/clB8jxnyTr-8NlBWaTEKiw/search?q=compliance%20experts
```

**How it works:**
- Loads the search page with authentication cookies
- Identifies results that have actual responses (excludes "No text responses")
- Automatically clicks "Expand" on results with content
- Extracts the full expanded content

**Status:** Script created but needs testing. May require adjustments to DOM selectors based on actual Ombud HTML structure.

**Use case:** Search Ombud for internal documentation (team structure, programs, partnerships) that isn't publicly available on twilio.com.

---

## export_ombud_cookies.js

**⚠️ NOT TESTED YET - Work in Progress**

Helper script to export Ombud authentication cookies (including HttpOnly cookies that can't be accessed via browser console).

**Usage:**
```bash
node ./scripts/export_ombud_cookies.js [output_file]
```

**Process:**
1. Opens a browser window
2. Navigates to app.ombud.com
3. Prompts you to login
4. After you press Enter, extracts all cookies
5. Saves to output_file (default: ombud_cookies.json)

**Why needed:** Browser console can't access HttpOnly authentication cookies, so this Puppeteer script is needed to extract them properly.
