# Claude Email Writer

An AI-powered email writing assistant for Twilio Pre-Sales Solutions Engineers. Drafts customer emails, finds resources, and maintains conversation history with automatic Apple Mail integration.

## Features

- **Email drafting** with verified links and link-centric approach
- **Apple Mail integration** - search and extract emails automatically
- **Conversation history** - organized by customer and timestamp
- **Multiple output modes**: Resource finding, Draft, Salesforce artifacts
- **Automatic clipboard copy** - emails ready to paste into Gmail

## Use Cases

### 1. Draft Customer Emails
- Answer technical questions with verified documentation links
- Provide resource lists for customer inquiries
- Handle follow-ups with full thread context

### 2. Resource Finding
- Find and verify Twilio documentation links
- Prioritize official sources (docs, blog, support, changelog)
- Return 1-5 options based on query specificity

### 3. Salesforce Artifacts
- Generate Executive Summary and Notes for RFP responses
- Structured format for business case documentation

## Setup

### Prerequisites
- macOS with Apple Mail configured
- Corporate Gmail synced to Apple Mail
- Git for version control

### Installation

1. Clone the repository:
```bash
git clone git@github.com:kuschanton/calude-email-writer.git
cd claude-email-writer
```

2. The project structure:
```
claude-email-writer/
├── CLAUDE.md              # System instructions (auto-loaded)
├── scripts/               # Apple Mail integration
│   ├── search_mail.applescript
│   └── README.md
├── history/               # Customer email threads (gitignored)
├── examples/              # Training examples (gitignored)
├── prompt/                # Original prompts (gitignored)
└── .gitignore            # Protects customer data
```

3. Open this directory in Claude Code or your preferred Claude-enabled IDE

## How It Works

### Email Writing Workflow

1. **Find the email** (automatic):
   - Say: "Find email from john@example.com from today"
   - Claude searches Apple Mail and shows you the email
   - Confirm to proceed

2. **Review the draft**:
   - Claude creates history entry under `history/YYYYMMDD_HHMM_customer/`
   - Displays email body in chat (clickable links)
   - Email is plain text (no markdown) - Gmail-ready

3. **Copy to clipboard** (automatic):
   - Email is copied via `pbcopy`
   - Paste directly into Gmail (Cmd+V)
   - No signature needed - Gmail adds automatically

4. **Follow-ups**:
   - Say: "New question from customer"
   - Claude creates `response_2.md`, `response_3.md`, etc.
   - Full thread context preserved

### Apple Mail Integration

The `search_mail.applescript` searches your inbox by:
- Sender name or email address
- Date range (today, yesterday, this week, last 30 days)

**Example queries:**
- "Find email from customer@example.com from today"
- "See recent email from John Doe"
- "Email from support this week"

**Script behavior:**
- Searches inbox only (fast)
- Returns most recent match
- Extracts full email thread
- 60-second timeout built-in

## Configuration

### Customizing Search

Edit `scripts/search_mail.applescript` to:
- Search all mailboxes (slower): Change `messages of inbox` to search all accounts
- Adjust default date range: Change `set daysBack to 30`

### Output Preferences

All settings are in `CLAUDE.md`:
- Email tone and style
- Link verification requirements
- Output formats per mode
- History naming conventions

## Important Notes

### Link Verification
- **All URLs in email body are verified** before sending
- Uses WebFetch to check 200 OK response
- Better to omit than include broken links
- "Links used" section (for tracking) doesn't require verification

### Plain Text Only
- No markdown formatting (**bold**, *italic*, etc.)
- No em dashes (—) - use hyphens (-)
- Plain text is Gmail-friendly and doesn't look AI-generated

### Data Privacy
- Customer data (`history/`, `examples/`, `prompt/`) is gitignored
- Safe to share repository with colleagues
- Only system code is version controlled

## Troubleshooting

### Email search is slow
- Script searches all mailboxes by default
- Reduce date range: "from today" vs "this week"
- Check Apple Mail is synced and not indexing

### pbcopy doesn't work
- Ensure clipboard permissions are enabled
- Fallback: Copy from `history/YYYYMMDD_HHMM_customer/response.md`

### Links don't work in email
- All links are verified before inclusion
- If verification fails, link is omitted
- Check WebFetch permissions

## Commands

### Search for customer threads:
```
"Any threads for [customer name]?"
"Do I have threads?"
```

### Start new thread:
Provide email content or say:
```
"Find email from customer@example.com from today"
```

### Continue existing thread:
```
"New question from customer"
```

## Project Structure Details

### History Directory
```
history/
└── YYYYMMDD_HHMM_customer_name/
    ├── context.md          # Customer question + full thread
    ├── response.md         # Your email response
    ├── response_2.md       # Follow-up responses
    └── attachments/        # PDFs, screenshots
```

### Naming Convention
- Format: `YYYYMMDD_HHMM_customer_name` or `YYYYMMDD_HHMM_brief_summary`
- Customer name: lowercase, underscores (e.g., `acme_corp`)
- No customer name: brief summary (max 50 chars): `api_timeout_issue`

## Contributing

This is a personal workflow tool. If you fork it:
1. Update `.gitignore` to protect your customer data
2. Customize `CLAUDE.md` for your use case
3. Adjust `search_mail.applescript` for your Mail setup

## License

Internal use only - not for public distribution.
