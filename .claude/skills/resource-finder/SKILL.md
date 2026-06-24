---
name: resource-finder
description: Find and display Twilio documentation resources with explanations
when_to_use: When user explicitly asks for "resources", "links", "docs", "show me", "what are the options", or wants to see available documentation without drafting a full response
---

# Resource Finder

Find Twilio documentation resources and display them with brief explanations.

## Purpose

User wants to see available documentation/resources on a topic, NOT a drafted email or full answer. Just the links with context.

## Workflow

### 1. Understand the Query
- Parse what the user is asking for
- Identify if it's specific/canonical or broad/exploratory

### 2. Invoke `/find-resources`
- Pass the query to `/find-resources` skill
- Receive back: verified URLs, descriptions, search summary

### 3. Determine Number of Options
**Adaptive options:**
- Default target = 3 options
- If ask is specific/canonical: return 1-2 top matches
- If ask is broad/exploratory or multi-part: return 3-5 options covering the facets

### 4. Format and Display

**Output format:**

1. **First**, print a compact explanation list (outside any code block):
   ```
   1. Title - 1-2 sentence summary; Why included: <short reason>
   2. Title - 1-2 sentence summary; Why included: <short reason>
   3. Title - 1-2 sentence summary; Why included: <short reason>
   ```

2. **Then**, print exactly one fenced code block containing only the URLs, one per line, in the same order:
   ```
   https://example.com/doc1
   https://example.com/doc2
   https://example.com/doc3
   ```

**No titles or numbering inside the code block - just clean URLs.**

---

## Example Output

```
1. Send and receive RCS messages - Step-by-step guide for sending RCS messages with automatic fallback to SMS/MMS; Why included: Direct implementation guide for your use case

2. RCS Compliance Onboarding Guide - Compliance requirements and approval process for RCS senders; Why included: You'll need to complete this before going live

3. RCS Messaging Best Practices and FAQ - Common questions about RCS capabilities, limitations, and troubleshooting; Why included: Answers device compatibility and fallback questions
```

```
https://www.twilio.com/docs/rcs/send-an-rcs-message
https://help.twilio.com/articles/49174994355355-RCS-Compliance-Onboarding-Guide
https://help.twilio.com/articles/29076535334043-RCS-Messaging-Best-Practices-and-FAQ
```

---

## Quality

- All URLs already verified by `/find-resources` skill
- Explanations should be brief but specific enough to help user choose
- "Why included" should explain the relevance to their specific question

---

## Clarification

- Ask at most three brief clarifying questions only if essential to proceed
- If you ask, do not output results in the same message
