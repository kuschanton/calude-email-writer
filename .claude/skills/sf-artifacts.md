---
name: sf-artifacts
description: Generate Salesforce artifacts (USE CASE, RISKS, NOTES) from customer call notes
when_to_use: When user explicitly asks for "Salesforce artifacts", "SF artifacts", or deliverables for Salesforce. Auto-detect or explicit invocation.
---

# Salesforce Artifacts Generator

Generate technical win artifacts for Salesforce: USE CASE, RISKS, and NOTES sections.

## Purpose

As a Solutions Engineer, your responsibility is **technical win**. The artifacts should focus on technical implementation details, architecture, and solutions discussed.

## Formatting

**CRITICAL**: See `formatting_rules.md` for complete formatting guidelines. Key rules:
- Plain text only - NO markdown (no bold, italic, code blocks, headers)
- Use only dashes for top-level items, tabs for sub-items
- No long dashes (em dashes —) - use regular hyphens (-)
- Structure with newlines and clear section labels

---

## Output Format

Generate exactly three sections in a single fenced code block:

```
USE CASE:
[3-5 concise sentences describing business problem and proposed Twilio solution]

RISKS:
[Documented risks - see detailed instructions below]

NOTES:
[Technical notes - see detailed instructions below]
```

---

## USE CASE Section

- 3-5 concise sentences
- Describe the business problem
- Describe the proposed Twilio solution
- Focus on why this matters to the customer

---

## RISKS Section

### Purpose
Document technical, compliance, commercial, and operational risks that could block or delay deal closure. Combine risks explicitly mentioned in the call with typical risks for the solution architecture, products, and region based on research.

### Research Requirement
- **Limit research to 3-5 web searches maximum** (5-7 minutes total)
- **Invoke `/find-resources`** to research Twilio products discussed
- **Prioritize Twilio market-specific regulatory pages** for SMS/Voice/Phone Numbers
- Search queries: `"Twilio [product] [country] regulatory guidelines site:twilio.com"`
- Look up regional compliance requirements if relevant (GDPR, HIPAA, carrier restrictions)
- Search for known limitations, common failure patterns, integration challenges
- If no information exists, add as risk and note "Mitigation: TBD - requires research"

### Regional Focus
- For multi-region deployments, prioritize:
  1. Key regions with most traffic/volume
  2. Challenging regions: Middle East (KSA, UAE, Turkey), Asian countries (China)
- If customer operates in multiple regions but only one discussed on call, focus research there

### What to Include
- Technical risks: product limitations, architecture gaps, integration complexity, scalability concerns, data residency constraints
- Compliance risks: regulatory blockers (HIPAA, GDPR), carrier restrictions, consent requirements, legal constraints, legal entity requirements
- Commercial risks: pricing sensitivity, competitive threats, commitment friction, churn risk
- Operational risks: implementation complexity, timeline pressures, resource constraints, dependency on third parties
- Migration risks: if switching from another provider, what could go wrong
- Typical risks for use case: CPS limits for outbound calling, messaging throughput for high-volume senders, API rate limits
- **Include all risks identified** - user will filter. Better to log more than miss critical ones.
- Use judgment to filter obvious non-issues (e.g., API limits for low-volume SMS)

### Risk Categories to Consider
- Product availability/feature gaps in required region
- Scale/volume risks (throughput, rate limits, CPS for Voice, messaging throughput, approval delays)
- Integration complexity with customer's existing systems
- Compliance and regulatory blockers
- Carrier or third-party dependencies (Meta for WhatsApp, carrier approvals for 10DLC, etc.)
- Customer technical capability concerns
- Competitive displacement risk
- Pricing/commercial misalignment

### Structure and Grouping

Group into two sections:

**Section 1: Discussed Risks** (explicitly mentioned in call)
- Lead with risk title
- Add sub-items: specific details, business impact
- Severity: Base on what was discussed. If not discussed, add "Potential severity: [Critical/High/Medium/Low]"
- Mitigation: If discussed, label as "Discussed mitigation: [details]". If not, leave blank or note "No mitigation discussed"

**Section 2: Potential Risks** (identified through research, not mentioned in call)
- Lead with risk title
- Add sub-items: why this is a risk, what could go wrong
- Severity: Always include "Potential severity: [Critical/High/Medium/Low]"
- Mitigation: Label as "Potential mitigation: [details]" if you have suggestions based on research

### Voice and Tone
- Be specific: "WhatsApp EU data residency unclear - Meta backend may route to US regardless of Twilio regionalization" not "Data residency concerns"
- Flag severity through detail: critical risks get more sub-items and specificity
- Log more risks rather than less - user will filter. Don't be overly cautious.
- Frame factually with business context

### Ordering Within Each Section
1. Most critical/deal-blocking risks first
2. Then high-priority risks (cause significant delay >30 days or require executive approval)
3. Then operational/implementation risks (complexity but path forward exists)

### Example Structure
```
RISKS:

Discussed Risks:
- WhatsApp EU data residency may not meet GDPR requirements
	- Meta backend infrastructure may route data to US regardless of Twilio regionalization
	- Customer cannot transmit health data to US without data privacy impact assessments by all clients
	- Blocks launch of Treatment Plan Agent product (currently in alpha/beta)
	- Discussed mitigation: Anton to confirm feasibility with Twilio product team, provide definitive guidance

Potential Risks:
- RCS limited HIPAA compliance (research finding)
	- RCS not HIPAA-compliant, may face same limitation as WhatsApp for healthcare use cases
	- Customer handles GDPR-defined health data in all communications
	- Potential severity: High (blocks RCS channel for sensitive communications)
	- Potential mitigation: Restrict RCS to non-sensitive appointment reminders, use SMS for health data
```

---

## NOTES Section

### Scope and Detail Level
- Include all major technical discussion points (topics discussed for >2 minutes)
- Target 5-15 top-level bullet points depending on call complexity:
  - 30-minute call = approximately 5-8 top-level points
  - 60-minute call = approximately 10-15 top-level points
- Brief mentions (<1 minute) can be combined into a single bullet or omitted
- Each top-level bullet should have 2-5 sub-items with specific details
- Prioritize: technical decisions, integration approaches, blockers/challenges over general product capabilities

### What to Include (only if discussed on call)
- Integration architecture: detailed technical approach, middleware requirements, API integration patterns, data flow
- Technical implementation details: specific APIs discussed, SDKs, authentication methods, webhook configurations
- Technical requirements: what customer needs technically, capabilities required, performance requirements
- Technical blockers and challenges: implementation challenges, missing OOTB integrations, custom development required, migration complexities
- Technical decisions made: architecture choices, technology selections, implementation approaches
- Product capabilities: specific Twilio products/features discussed, how they address technical requirements
- Testing and validation approach: sandbox/testing approach, POC requirements (only if discussed)
- Commercial topics: include briefly only if they have technical implications

### Operating Principles
- ONLY document what was explicitly discussed or clearly stated in the call
- DO NOT invent, assume, or assess risks/challenges that weren't mentioned
- DO NOT include category sections if that topic wasn't discussed
- DO NOT use category headers as separate sections - weave topics naturally
- Group related technical topics together

### Ordering
1. Integration architecture first
2. Technical requirements and blockers/risks/challenges
3. Capabilities and products discussed
4. Testing approach (if discussed)

### Voice and Perspective
- Use neutral, factual third-person perspective focused on outcomes and decisions
- Good examples: "No OOTB integration available - customer must build middleware", "Customer requires virtual numbers per country"
- Avoid: "I explained...", "We told them...", "They asked..."
- Exception: For next steps, be specific about who: "SE to send API docs", "Customer to review internally"
- Write as documentation for future reference, not personal notes

### Labeling Technical Challenges
- "Customer responsibility:" for tasks customer must own
- "No OOTB integration available" when describing integration gaps
- "Migration complexity:" when discussing migrations
- Frame factually based on what was discussed

### Technical Win Context
Technical Win = customer's Technical Owner confirms selection criteria is satisfied and there's a plan to launch. NOTES should document:
- What technical requirements or selection criteria were discussed
- How Twilio capabilities address those requirements
- Technical blockers, gaps, or challenges identified (be transparent)
- Customer's level of confidence in the solution
- Path forward and plan to implement
- Balance: show both what works AND what's challenging, with mitigation approaches

### Next Steps Section (REQUIRED - always include as last bullet)
- Always end NOTES with "Next Steps" as the final top-level dash item
- Format: "Next Steps" followed by sub-items with tabs
- Focus on immediate next steps and critical actions for advancing the deal
- Each next step should specify: who (person/team), what (action), by when (date/timeline) - ONLY if explicitly mentioned in call
- Include action items that were clearly agreed upon OR strongly implied as commitments
- Examples that COUNT: "I'll send docs", "we need to review internally", "let's schedule follow-up", "customer will test"
- Examples that DON'T count: vague ideas without commitment, theoretical future possibilities
- If 7+ next steps discussed, prioritize top 5-7 most critical
- For conditional next steps, note the condition
- If action agreed but no timeline: "Customer to review architecture proposal (timeline TBD)"
- If NO next steps discussed: include "Next Steps" with single sub-item "To be determined"

### Example Structure
```
NOTES:
- Integration architecture requires middleware between Platform X and Twilio
	- No OOTB integration available - customer must build custom middleware
	- Middleware translates webhooks between platforms using Twilio Functions
	- Customer responsibility: build and maintain middleware code
	- Estimated 2-4 week development timeline discussed
- Customer technical requirements clarified
	- Virtual phone numbers per country (French number for France, etc.)
	- Dynamic button URLs in WhatsApp templates
	- Two-way webhook communication for status updates
- Next Steps
	- Customer to review middleware approach internally (by May 20)
	- SE to send API documentation and integration guide (by May 15)
	- AE to schedule follow-up call (timeline TBD)
```

---

## Workflow

1. **Parse call notes** provided by user
2. **Research risks** - invoke `/find-resources` for products/architecture discussed (3-5 searches max)
3. **Draft USE CASE** (3-5 sentences)
4. **Draft RISKS** (Discussed + Potential, from call + research)
5. **Draft NOTES** (technical details from call, including Next Steps)
6. **Display artifacts** in chat with separators so user can review
7. **Copy to clipboard**:
   - Save to `/tmp/sf_artifacts.txt` using heredoc
   - Copy using script: `./scripts/copy_to_clipboard.sh /tmp/sf_artifacts.txt`
   - Script outputs: "✅ Copied to clipboard: /tmp/sf_artifacts.txt"

---

## Special Command: "cb"

If user sends just "cb", immediately re-copy the last drafted artifacts:
- Copy from `/tmp/sf_artifacts.txt`
- Use: `./scripts/copy_to_clipboard.sh /tmp/sf_artifacts.txt`
- Respond only: "✅ Copied to clipboard!"

---

## Output

1. Display artifacts in fenced code block with all three sections
2. Copy to clipboard automatically
