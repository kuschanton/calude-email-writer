---
name: rfx
description: Answer RFP, RFQ, RFI, and questionnaire questions with research and verified documentation
when_to_use: When user provides RFP/RFQ/RFI questions, security questionnaires, compliance questionnaires, or any structured list of questions to answer
---

# RFX Question Answerer

Answer RFP, RFQ, RFI, and questionnaire questions with concise, accurate responses backed by verified Twilio documentation.

## Purpose

Provide concise, accurate answers to structured questions (RFPs, security questionnaires, compliance forms, etc.) with proper documentation references.

## Formatting

**CRITICAL**: See `formatting_rules.md` for complete formatting guidelines. Key rules:
- Plain text only - NO markdown syntax
- No long dashes (em dashes —) - use regular hyphens (-)
- Brief, clear, technical tone
- Link-centric: reference documentation, don't write long explanations

---

## Workflow

### 1. Parse Questions
- Identify how many questions
- Group related questions if appropriate (e.g., multiple questions about the same topic)
- Understand what Twilio products/features are being asked about

### 2. Check Golden Responses First
Before researching, check if similar questions exist in golden responses:
- Golden responses located in: `rfp/golden_responses/`
- Categories available: company, coverage, webrtc, regulatory, portability, migration, quality, feature, branded_caller_id, analysis, monitoring, sla_support, security, integration, commercial
- Use `grep` to search across golden response files for keywords from the question
- If similar question found, use/adapt that answer (it's already been verified and approved)
- If no match, proceed to research

### 3. Research Each Question (if not in golden responses)
For each question without a golden response match:
- Invoke `/find-resources` with the query
- Receive back: verified URLs, descriptions

### 3. Draft Answers
For each question:
- **Brief answer** (1-4 sentences) - direct, factual response
- **Reference documentation** (URL) if available and relevant
- Keep it concise - answer the question, don't over-explain
- If question doesn't apply to Twilio: say "N/A" or "Not applicable" with brief explanation

### 4. Format Output

**Structure:**
```
Q1: [Question text if short, or "Question about X" if long]
A: [Brief answer]
[Reference URL if applicable]

Q2: [Question text if short, or "Question about Y" if long]
A: [Brief answer]
[Reference URL if applicable]

...
```

### 5. Display Answers
- Print separator: `---`
- Print label: `RFX ANSWERS:`
- Print all Q&A pairs (plain text)
- Print separator: `---`

### 6. Copy to Clipboard
- Save content to `tmp/rfx_answers.txt` using heredoc:
  ```bash
  cat > tmp/rfx_answers.txt <<'EOF'
  [answers content]
  EOF
  ```
- Copy using script: `./scripts/copy_to_clipboard.sh tmp/rfx_answers.txt`
- Script outputs: "✅ Copied to clipboard: tmp/rfx_answers.txt"

### 7. Show Links Used
After the answers, output a "Links used:" section with all URLs in a code block for reference.

---

## Answer Guidelines

### Tone
- Factual and direct
- Technical but accessible
- No marketing fluff
- Focus on "what" and "how", backed by "where" (documentation)

### Length
- Most answers: 1-3 sentences
- Complex answers: up to 4-5 sentences
- If question requires yes/no: say "Yes" or "No" then brief explanation

### When to Include URLs
- When answer references specific capabilities, features, or compliance
- When customer might need more detail
- When answer would benefit from official documentation
- NOT needed for every answer (e.g., simple yes/no questions may not need a URL)

### Special Question Types

**Security questions:**
- Be factual about Twilio's security posture
- Reference official security documentation
- If you don't know, say "Please contact Twilio Security team for detailed information"

**Compliance questions (GDPR, HIPAA, SOC2, etc.):**
- Reference Twilio's compliance certifications and documentation
- Be accurate - don't overstate compliance
- If unsure, say "Please refer to Twilio Trust Center or contact Twilio Compliance team"

**Pricing questions:**
- Provide general pricing structure if known
- Always reference official pricing pages
- Note: "Pricing may vary based on volume and contract terms"

**Product capability questions:**
- Answer based on current product capabilities
- Reference product documentation
- If feature doesn't exist: say so clearly, don't make promises

---

## Example Output

```
Q1: Does Twilio support two-factor authentication (2FA)?
A: Yes, Twilio Verify provides 2FA capabilities with SMS, Voice, Email, TOTP, and Push authentication channels. It includes built-in fraud detection and rate limiting.
https://www.twilio.com/docs/verify

Q2: Is Twilio HIPAA compliant?
A: Yes, Twilio offers a HIPAA-eligible platform for healthcare communications. Customers must execute a Business Associate Agreement (BAA) with Twilio and use HIPAA-eligible products and configurations.
https://www.twilio.com/legal/tos#hipaa

Q3: What is the SLA for Twilio Programmable Messaging?
A: Twilio provides a 99.95% uptime SLA for Programmable Messaging API. Full SLA terms and conditions are available in the Twilio Service Level Agreement documentation.
https://www.twilio.com/legal/service-level-agreement
```

---

## Special Command: "cb"

If user sends just "cb", immediately re-copy the last drafted answers:
- Copy from `tmp/rfx_answers.txt`
- Use: `./scripts/copy_to_clipboard.sh tmp/rfx_answers.txt`
- Respond only: "✅ Copied to clipboard!"

---

## Clarification

- If questions are ambiguous or lack context, ask brief clarifying questions
- Ask at most three questions
- If you ask, do not output results in the same message

---

## Output

1. Display answers with separators
2. Copy to clipboard automatically
3. Show "Links used:" section with all URLs
