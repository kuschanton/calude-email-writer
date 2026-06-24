---
name: find-resources
description: Find and verify Twilio documentation links using 5-step research workflow with quality checks
when_to_use: When drafting emails, answering questions, or user explicitly asks for documentation/resources. Invoked by email-writer, sf-artifacts, rfx, resource-finder skills, or directly by user.
---

# Find Resources

Execute the 5-step resource finding workflow to locate, verify, and return Twilio documentation links.

## Workflow (EXECUTE IN ORDER)

### Step 1: Web Search

```bash
node ./scripts/google_cse_ui.js "[Product] [Feature] site:twilio.com"
```

- Scan results: title, URL, description
- Select 3-5 most relevant URLs based on:
  - Description matches query keywords
  - Prefer top-ranked results (Google ranks by relevance)
  - Prefer docs/help.twilio.com over blog posts
- IF URLs selected → CONTINUE to Step 2
- IF no relevant URLs found → SKIP to Step 3 (check KB)

### Step 2: Verify URLs from Web Search

FOR EACH URL from Step 1:
- IF URL is `help.twilio.com` → Use `node ./scripts/fetch_help_article.js "URL"`
- ELSE → Use WebFetch with prompt: "Does this page provide instructions or information about [original question]?"
- Evaluate content using **Content Relevance Criteria** (see below)
- IF returns 200 OK AND content is relevant → Add to verified_urls list
- IF 404/failed/not relevant → Discard

CONTINUE to Step 3 (always check KB)

**Note**: See `scripts/README.md` for exact script usage and parameters

### Step 3: Check Knowledge Base

Invoke `/kb` skill to search `knowledge_base.md`:
- Search for query keywords in section headers and descriptions
- Compare KB links with verified_urls from Step 2
- For each link (KB or verified), evaluate using Content Relevance Criteria
- Select the link(s) that best address the specific question

IF we have links (from verified_urls OR KB) → CONTINUE to Step 4
IF no links from either source → CONTINUE to Step 5 (still draft response even without docs)

### Step 4: Update Knowledge Base

- IF using new verified URL not in KB → Invoke `/kb` to add with description
- IF using existing KB URL + learned new info from page content → Invoke `/kb` to update description
- **Never duplicate** - check if link exists before adding

CONTINUE to Step 5

### Step 5: Return Results

Return structured data to calling skill:
```json
{
  "urls": [
    {"url": "https://...", "description": "...", "relevant": true}
  ],
  "kb_updated": true/false,
  "search_summary": "brief summary of what was searched and found"
}
```

IF no links found → Return:
```json
{
  "urls": [],
  "kb_updated": false,
  "search_summary": "No specific documentation found for [topic]"
}
```

---

## Content Relevance Criteria

A page is **relevant** if:
- Page title or first paragraph mentions the query topic
- Content provides instructions, setup steps, or explanations about the query topic
- Content directly answers the customer's question

A page is **NOT relevant** if:
- Only tangentially related (mentions query topic but doesn't explain it)
- Generic overview page that doesn't provide actionable information
- Wrong product/service (e.g., Voice docs when query is about Messaging)
- Outdated or deprecated content

**Preference order:**
1. Docs over blog (docs are authoritative, maintained)
2. Specific over general (targeted solution over broad overview)
3. Setup/quickstart guides over API reference (unless API question)
4. Recent over old (check dates if available)

---

## Quality Checks

### URL Verification Requirements
- **MANDATORY**: Every URL must return 200 OK before including
- Must be publicly accessible (no login/Console gating)
- Use canonical HTTPS URL
- Remove tracking params
- No URL shorteners
- **Exception**: Console URLs (`console.twilio.com`) - never verify (always login-gated)

### Special Cases
- **help.twilio.com articles**: Use `fetch_help_article.js` script for clean content extraction
- **Console URLs**: Skip verification, but warn if suggesting to customer (login-gated)
- **Blog posts**: Verify and check publication date if available

---

## Prioritization

1. **Twilio-owned sources first**: twilio.com/docs, twilio.com/blog, help.twilio.com, twilio.com/changelog, twilio.com/pricing
2. **External sources**: Only if Twilio lacks a strong match or external source is uniquely authoritative

---

## Output Modes

### For skills invoking this:
Return structured JSON (see Step 5 above)

### For direct user invocation:
Display findings:
- "Searched for: [query]"
- "Found X relevant links"
- List each with title and description
- Note if KB was updated
