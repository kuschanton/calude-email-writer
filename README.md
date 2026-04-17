# Claude Email Writer

An AI-powered email writing assistant for Twilio Pre-Sales Solutions Engineers. Drafts customer emails, finds resources, and maintains conversation history with automatic Apple Mail integration.

## Use Cases

### Draft Customer Emails
Answer technical questions with verified documentation links, provide resource lists, and handle follow-ups with full thread context.

### Resource Finding
Find and verify Twilio documentation links. Returns 1-5 options prioritizing official sources (docs, blog, support, changelog).

### Salesforce Artifacts
Generate Use Case and SE Notes from Gong call transcripts in structured format for Salesforce opportunities.

## Setup

### Prerequisites
- macOS with Apple Mail app
- Twilio email logged in via Apple Mail (emails must sync locally)
- Claude Code or Claude-enabled IDE

### Installation

1. Clone the repository:
```bash
git clone git@github.com:kuschanton/calude-email-writer.git
cd claude-email-writer
```

2. Open this directory in Claude Code

That's it! The system is ready to use.

## How to Use

### Writing an Email

**Step 1: Find the email**

Say: "Find email from john@example.com from today"

Claude searches Apple Mail and displays the email. Confirm to proceed.

**Step 2: Review the draft**

Claude displays the email body in plain text with clickable links. The email is automatically saved to `history/YYYYMMDD_HHMM_customer/response.md`

**Step 3: Copy to clipboard**

Email is automatically copied via pbcopy. Just paste into Gmail (Cmd+V). No signature needed - Gmail adds it.

### Example Queries

```
"Find email from customer@example.com from today"
"Find email from john.doe@example.com from last week"
```

### Follow-up Emails

Say: "New question from customer"

Claude knows the context, creates `response_2.md`, and maintains full thread history.

### Manual Email Input

If you prefer, paste the email content directly or provide a PDF. Claude will process it the same way.

## What to Expect

### Email Output
- **Plain text** - no markdown formatting, Gmail-ready
- **Verified links only** - all URLs checked before inclusion
- **Concise and professional** - link-centric approach (brief explanation + link to docs)
- **Ready to paste** - in your clipboard, no editing needed

### Conversation History
Every interaction creates/updates a folder in `history/`:
```
history/YYYYMMDD_HHMM_customer_name/
├── context.md      # Customer's question + full thread
├── response.md     # Your first reply
├── response_2.md   # Follow-up replies
└── attachments/    # Any PDFs or screenshots
```

### Finding Past Threads

Say: "Any threads for Acme Corp?"

Claude lists all matching threads with timestamps and summaries.

## Important Notes

### Link Verification
Every URL in the email body is verified (200 OK check) before sending. Broken links are omitted automatically.

### Plain Text Formatting
- No markdown (**bold**, *italic*, `code`)
- No em dashes (—) - use hyphens (-)
- Keeps emails natural and professional

### Data Privacy
Customer data (`history/`, `examples/`, `prompt/`) is gitignored. Safe to share the repository with colleagues.

## Troubleshooting

**Email search is slow:** Reduce date range ("from today" vs "this week"). Check Apple Mail is synced.

**pbcopy doesn't work:** Fallback - copy from `history/YYYYMMDD_HHMM_customer/response.md`

**Links broken:** If WebFetch can't verify, links are automatically omitted from draft.

---

## Technical Details

### Project Structure
```
claude-email-writer/
├── CLAUDE.md              # System instructions (auto-loaded)
├── README.md              # This file
├── scripts/               # Apple Mail integration
├── history/               # Customer threads (gitignored)
└── .gitignore            # Protects customer data
```

### Apple Mail Script
`scripts/search_mail.applescript` searches inbox by sender and date range. Configurable via script parameters.

### Configuration
Edit `CLAUDE.md` to customize:
- Email tone and style
- Link verification behavior
- Output formats
- History naming

### Contributing
Fork and customize for your workflow. Update `.gitignore` to protect your customer data.

---

**License:** Internal use only
