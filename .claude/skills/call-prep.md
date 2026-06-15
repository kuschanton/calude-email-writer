---
name: call-prep
description: Generate technical call preparation notes for Solutions Architect including discussion points, questions, resources, opportunity volume estimate, and risks
when_to_use: When user asks for call prep, meeting prep, call preparation notes, or similar. User will provide email thread or briefing materials directly in prompt.
---

# Call Preparation Notes Generator

Generate comprehensive technical call preparation notes for Solutions Architect role.

## Purpose

As a Solutions Architect, you need structured prep notes covering:
- Technical discussion points (integration, scale, compliance)
- Questions to ask (technical, business, implementation)
- Relevant resources and documentation
- Opportunity volume estimate (rough order of magnitude)
- Risks (timeline, technical, compliance, commercial)

## Formatting

**CRITICAL**: See `formatting_rules.md` for complete formatting guidelines. Key rules:
- Use markdown format (for Obsidian)
- Use ## headers for sections
- Use **bold** for key metrics, dates, names
- Use `code` for product names, API names, technical terms
- Use markdown bullets and [link text](URL) format
- No long dashes (em dashes —) - use regular hyphens (-)

---

## Workflow

### 1. Gather Context

User will provide:
- Email thread, meeting notes, or briefing materials (pasted directly)
- Optional: Call type (discovery, technical deep dive, POC kick-off, escalation)
- Optional: Keywords for resource search

**If call type not provided**: Ask user: "What type of call is this? (discovery / technical deep dive / POC kick-off / escalation / other)"

### 2. Research Resources

**Always search for relevant integration resources**:
- Extract keywords from briefing materials (e.g., "ServiceNow", "Salesforce", "Zendesk", custom system names)
- Search for Twilio blog posts and documentation
- Query: `"Twilio [keyword] integration blog tutorial site:twilio.com"`
- Limit to 2-3 searches (don't over-research)

### 3. Calculate Opportunity Volume (Rough Estimate)

**Purpose**: Rough order of magnitude - is this 1K, 10K, 100K, 1M opportunity?

**Method**:
- Extract volumes mentioned in briefing (SMS count, voice minutes, WhatsApp messages, etc.)
- Use Twilio list prices (approximate values below)
- Calculate ONLY for products explicitly mentioned in briefing
- Express as monthly/annual
- 10K precision is fine

**Approximate List Prices** (use for estimation):
- SMS US: $0.0079/message
- SMS Germany: $0.075/message
- SMS International (avg): $0.05/message
- Voice US: $0.013/min inbound, $0.014/min outbound
- Voice Germany: $0.01/min inbound, $0.02/min outbound
- WhatsApp: $0.005-0.03/message (varies by type)
- Verify SMS: $0.05/verification
- Toll-free numbers US: $2/month + usage
- Phone numbers (local): $1-5/month depending on region

**Format**:
```
OPPORTUNITY VOLUME ESTIMATE:
[Product] - [Volume] × [Unit Price] = ~$[Amount]/[period]
Total Estimated Annual Opportunity: ~$[X]K - $[Y]K
```

Example:
```
OPPORTUNITY VOLUME ESTIMATE:
SMS Germany - 30,000/year × $0.075 = ~$2.3K/year
Voice Germany - Est 500 min/month × $0.02 = ~$10/month = ~$120/year
Total Estimated Annual Opportunity: ~$2K - $3K
```

### 4. Generate Prep Notes

Output structure (see detailed sections below):
1. Meeting header (date, time, attendees if known)
2. Background summary
3. Call type & objectives
4. Technical discussion points
5. Questions to ask (grouped: technical, business, implementation)
6. Resources/documentation links
7. Opportunity volume estimate
8. Risks
9. Next steps

---

## Output Sections

### 1. Meeting Header

```
CALL PREP: [Customer Name] - [Topic]
Meeting: [Date/Time if known, otherwise "TBD"]

ATTENDEES:
Customer Side: [names/roles if known]
Twilio Side: [names/roles if known]
```

### 2. Background Summary

- 3-5 sentences
- What is the customer trying to achieve?
- Current state (if any)
- Why are they talking to Twilio now?

### 3. Call Type & Objectives

State call type and what you need to accomplish:
- Discovery: understand use case, technical requirements, decision criteria
- Technical Deep Dive: validate architecture, discuss integration approach
- POC Kick-off: define scope, success criteria, timeline
- Escalation: unblock technical issue, provide solution path

### 4. Technical Discussion Points

**Focus areas** (prioritize based on briefing):
- Current state / existing systems
- Integration approach (API, SDK, webhooks, existing integrations)
- Scale/throughput requirements
- Compliance (GDPR, data residency, certifications, consent management)
- Security/authentication model
- High availability/redundancy needs
- Monitoring/observability requirements
- Existing tech stack (languages, frameworks, infrastructure)
- Development resources (who builds, who maintains)
- Timeline constraints

**Structure**: Bulleted list, group related topics

### 5. Questions to Ask

Group into categories:

**Technical Questions**:
- Integration model, API usage, authentication
- Scale/volume, concurrency, peak loads
- Compliance requirements, data residency
- Monitoring, alerting, SLAs
- Existing systems and tech stack

**Business Questions**:
- What's driving this project? (why now?)
- Timeline for decision and implementation?
- Who are the stakeholders and decision makers?
- Budget allocated?
- Success criteria?
- Competitive evaluation?

**Implementation Questions**:
- Who handles development/integration on customer side?
- Internal approvals needed?
- Existing vendor relationships?
- Migration complexity (if switching providers)?

### 6. Resources/Documentation

**Always search** for relevant resources based on keywords in briefing.

Format:
```
RESOURCES:

[Category if multiple types, e.g., "ServiceNow Integration"]
1. [Title/Description]
   [URL]

2. [Title/Description]
   [URL]

[API Documentation if relevant]
- [Product] API: [URL]
```

### 7. Opportunity Volume Estimate

See section 3 above for calculation method.

### 8. Risks

**Purpose**: Identify technical, timeline, compliance, and commercial risks that could block or delay the deal.

**Research Requirement**:
- Limit to 2-3 web searches maximum (3-5 minutes total)
- Search for product limitations in mentioned regions
- Check regulatory/compliance requirements if relevant
- Look for known integration challenges

**Structure**: Two sections

#### Discussed Risks
Risks explicitly mentioned in briefing materials:
- Risk title
- Sub-items: specific details, business impact
- Severity: [Critical/High/Medium/Low] based on what was discussed
- Mitigation: If discussed, note "Discussed mitigation: [details]"

#### Potential Risks
Risks identified through analysis/research, not mentioned in briefing:
- Risk title
- Sub-items: why this is a risk, what could go wrong
- Potential severity: [Critical/High/Medium/Low]
- Potential mitigation: [details] if you have suggestions

**Risk Categories**:
- Timeline risks: tight deadlines, dependencies, resource constraints
- Technical risks: product limitations, architecture gaps, scale/throughput concerns, integration complexity
- Compliance risks: GDPR, data residency, carrier restrictions, consent requirements, legal entity requirements
- Commercial risks: pricing sensitivity, competitive pressure, commitment friction
- Operational risks: implementation complexity, customer technical capability, third-party dependencies
- Migration risks: switching from another provider, data migration complexity

**Ordering Within Each Section**:
1. Most critical/deal-blocking risks first
2. High-priority risks (cause delay >30 days or require executive approval)
3. Operational/implementation risks (complexity but path forward exists)

**Urgency Indicators** (flag in risks):
- Tight timeline (decision needed within 2-4 weeks)
- Competitive evaluation in progress
- Executive pressure/visibility
- POC with hard deadline
- Existing contract expiration date

**Voice and Tone**:
- Be specific with details and business impact
- Flag severity through detail (critical risks get more sub-items)
- Log more risks rather than less - user will filter
- Include "Potential severity: [level]" for all potential risks

**Example Structure**:
```
RISKS:

Discussed Risks:
- POC timeline only 1 month vs customer's requested 3 months
	- Customer expects 3-month evaluation period
	- Twilio standard POC = 1 month maximum
	- May create friction during POC negotiation
	- Severity: Medium
	- Discussed mitigation: Need to clarify upfront, align on 1-month scope

Potential Risks:
- ServiceNow integration complexity unclear
	- Customer running ServiceNow version not mentioned in briefing
	- Integration approach differs between Notify plugin vs bidirectional API
	- Implementation timeline depends on chosen integration level
	- Potential severity: Medium
	- Potential mitigation: Confirm ServiceNow version on call, recommend integration level based on requirements
	
- Timeline pressure (urgent indicator)
	- Customer wants decision within 3 weeks for Q2 budget allocation
	- Competitive evaluation with 2 other vendors
	- Potential severity: High
	- Potential mitigation: Fast-track POC setup, schedule follow-up within 48 hours
```

### 9. Next Steps

What needs to happen after the call:
- Documentation to provide
- Follow-up meetings to schedule
- Technical work to complete (POC setup, integration testing, etc.)
- Internal coordination needed

---

## Output Format

**Display** prep notes in terminal, structured as outlined above.

**Save** to `tmp/call_prep.md` and copy to clipboard using:
```bash
./scripts/copy_to_clipboard.sh tmp/call_prep.md
```

**Final message**: "✅ Call prep notes copied to clipboard!"

---

## Example Usage

User: "Need call prep for Monday's meeting with SBES IT about ServiceNow SMS integration"
[User pastes email thread]