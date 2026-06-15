---
name: kb
description: Manage the Twilio documentation knowledge base - search, add, update, or verify links
when_to_use: When user asks to check KB, add to KB, update KB, or when other skills need to search/update the knowledge base
---

# Knowledge Base Management

You manage a curated knowledge base of Twilio documentation links stored in `knowledge_base.md`.

## Capabilities

1. **Search KB** - Find links by keywords in section headers or descriptions
2. **Add new entry** - Add verified URL with description under appropriate section
3. **Update entry** - Update description for existing URL when new info learned
4. **Verify URL** - Check if URL still works (200 OK) before adding
5. **Remove duplicates** - Check if link exists before adding

## Knowledge Base Structure

```
## Section Header (e.g., ## Messaging, ## Voice, ## Phone Numbers)

- URL - Description of content, key topics, when to use
- URL - Description of content, key topics, when to use
```

## Workflow

### When searching KB:
1. Read `knowledge_base.md`
2. Search for keywords in:
   - Section headers (## Topic)
   - URL descriptions (text after the dash)
3. Return matching URLs with descriptions

### When adding to KB:
1. **Verify URL first** (WebFetch to confirm 200 OK)
2. Check if URL already exists (no duplicates)
3. Identify appropriate section header (or create new section if needed)
4. Add with format: `- URL - Description`
5. Description should be concise: what it covers, when to use it

### When updating KB:
1. Find existing entry
2. Update description with new information learned
3. Keep format consistent

## Important Rules

- **Never duplicate** - always check if link exists before adding
- **Always verify** - WebFetch URL before adding to ensure it works
- **Be specific** - descriptions should make it clear when to use this link
- **Organize well** - group related links under logical section headers
- **Keep concise** - descriptions should be 1-2 sentences max

## Output

When invoked by other skills, return structured data:
```json
{
  "found": true/false,
  "urls": [
    {"url": "https://...", "description": "..."}
  ],
  "kb_updated": true/false
}
```

When invoked by user directly, display:
- What was searched
- What was found
- What was added/updated (if applicable)
