---
name: opp-account-manage
description: Manage opportunities and strategic accounts - create, update, track progress, suggest next steps and team involvement based on presales stage
when_to_use: User asks to create/update opp or account files, or says "create opp [name]" or "update opp [name]" or "show opp [name]" or "add notes to opp [name]"
---

# Opportunity & Account Management Skill

**Purpose**: Manage opportunities and strategic accounts - create, update, track progress, suggest next steps and team involvement based on presales stage.

---

## Overview

This skill manages two types of records:
1. **Strategic Accounts**: Files in `accounts/[account_name].md` - contain multiple opportunities under one account
2. **New Business Opportunities**: Files in `opps/[opportunity_name].md` - individual deals, each gets own file

**Detection**:
- If account exists in `accounts/` folder → Strategic
- If only record in `opps/` folder → New Business

---

## User Invokes This Skill

User will explicitly tell you:
1. **Create new account/opp**: "Create account FooBar" or "Create opp BazBar"
2. **Update existing**: "Update opp SBES_IT with notes from call"
3. **Review/show**: "Show me opp SBES_IT status"
4. **Post-call workflow**: After `/sf-artifacts` skill generates notes, user may say "update opp XYZ accordingly"

---

## Commands

### 1. Create New Record

**User Command**: "Create account [Name]" or "Create opp [Name]"

**Workflow**:
1. Ask user: "Is this Strategic Account or New Business?"
2. Ask for initial info:
   - Account/Opp name
   - Company info (industry, size, location)
   - Use case description
   - Products involved
   - Current status/stage
   - AE name
   - Expected close date (if known)
   - ACV/iACV estimate
3. Create file using appropriate template
4. Save to `accounts/[snake_case_name].md` or `opps/[snake_case_name].md`

---

### 2. Update Existing Record

**User Command**: "Update opp/account [Name] with [context]"

**Workflow**:
1. Read existing file
2. Parse update context (could be meeting notes, status change, new information)
3. Update appropriate sections:
   
   **EDITABLE SECTIONS** (replace/update existing content):
   - Pinned (add new links/docs)
   - Current State (replace bullet points to reflect latest status)
   - Open Items / Next Steps (replace with current action items)
   - Pending / Later (move items here when deferred)
   - Company Info (if changed)
   - Use Case (if refined)
   - Products (if new products added)
   - Customer Team (if new contacts)
   - Twilio Team (if team changes)
   - Partner (if partner involvement changes)
   - Risks (replace/reorder by current priority - most critical first)
   
   **LOG SECTIONS** (append new entries at TOP, never modify existing entries):
   - Meeting Notes (add new entry at top with latest date first)
   
4. **Suggest Involvement** (see section below) - regenerate completely
5. **Suggest Next Steps for Stage Progression** (see section below) - regenerate completely
6. Save updated file
7. Show user diff of what changed

**CRITICAL - Meeting Notes Ordering**:
- Always add new meeting notes at the TOP of the Meeting Notes section
- Most recent meeting = first entry
- Chronological order: newest → oldest (reverse chronological)
- Never modify or delete previous meeting notes
- Format: `### YYYY-MM-DD - [Meeting Type]` as header for each entry

---

### 3. Review/Show Record

**User Command**: "Show opp/account [Name]" or "What's status of [Name]?"

**Workflow**:
1. Read file
2. Display current state summary:
   - Current presales stage
   - Open items / next steps
   - Risks
   - Products
   - Team involvement
3. **Proactively suggest**:
   - Missing actions for current stage
   - Who should be involved (if not yet involved)
   - What's needed to progress to next stage

---

## File Templates

### Strategic Account Template

```markdown
# [Account Name]

## Pinned
- TBA

## Open Items / Next Steps
- [ ] TBA

## Current State

[2-3 sentence narrative summary for the overall account. Focus on: recent activity, overall account health, key opportunities or concerns, what's next strategically.]

**Example:** "Multiple active opportunities across messaging and voice products. Recent focus on ServiceNow integration POC (small opp) but real opportunity is broader communications platform discussion with Beatrice's team. Need to expand engagement beyond IT into business stakeholders."

## About
[Company description, industry, size, etc.]

## Strategy
[Account strategy, expansion opportunities]

## Customer Team
- [Name] - [Role] - [Email]
- TBA

## Twilio Team
- [AE Name] - AE
- Anton Kushch - SE
- [TAM Name] - TAM (if applicable)

## Twilio Usage

### Products
- [Product 1]
- [Product 2]

### Current Volume
- [Volume metrics if known]

## Opportunities

### [Opportunity 1 Name]

**Current State**: [Presales Stage]

**Description**: [Use case description]

**Products**:
- [Product list]

**Open Items**:
- [ ] [Action item]

**Action Items**:
- [ ] [Who] - [What] - [When]

**Est. ACV**: $[amount]

**Expected Close**: [Date]

---

### [Opportunity 2 Name]

[Same structure as above]

---

## Meeting Notes

### [Date] - [Meeting Type]

**Attendees**:
- Customer: [Names]
- Twilio: [Names]

**Summary**:
[Notes]

**Action Items**:
- [ ] [Who] - [What] - [When]

**Next Steps**:
- [Next meeting]
- [Follow-up actions]
```

---

### New Business Opportunity Template

```markdown
# [Opportunity Name]

## Pinned
- [Important links, docs, account SIDs, org charts, diagrams - keep at top for quick access]

## Current State

- [Bullet point 1: current phase/stage]
- [Bullet point 2: key blocker or progress]
- [Bullet point 3: what's next]
- [Additional bullets as needed - keep concise, NO SFDC field duplication]

## Company Info
- **Company**: [Name] | **Industry**: [Industry] | **Size**: [Employees/Revenue]
- **Location**: [HQ] | **Website**: [URL]

## Use Case

[1-2 sentence business problem + Twilio solution. Keep concise.]

## Products
- [Product 1], [Product 2], [Product 3]

## Open Items / Next Steps
- [ ] **[Owner]**: [Action item with clear ownership]
- [ ] **[Owner]**: [Action item]

## Pending / Later
- [ ] [Items deferred or deprioritized - use this section to capture things that are postponed]

## Customer Team
- [Name] - [Role] - [Email/Location if relevant]

## Twilio Team
- [AE Name] - AE | Anton Kushch - Presales Solutions Architect | [Others] - [Role]

## Partner
- [Partner Name] - [Contacts] ([role: implementation/resale/etc])

## Risks

- **[Risk title]** - [1-2 line description with context]
- **[Risk title]** - [Description]
- [Order by priority/severity - most critical first]

## Meeting Notes

### [YYYY-MM-DD] - [Meeting Type]

**Recording**: [Gong/Zoom link]

**Attendees**:
- Customer: [Names with roles]
- Twilio: [Names with roles]
- Partner: [If applicable]

**Summary**:

[1-2 sentence executive summary of what was discussed/decided]

**[Topic 1]**:
- [Key point or decision]
- [Key point or decision]

**[Topic 2]**:
- [Key point or decision]

**Action Items**:
- [Owner]: [Action item]
- [Owner]: [Action item]

[KEEP BRIEF: Max 4000 characters, typically 2000-3000. Match length of existing notes in file. No quotes section.]
```

---

## Suggest Team Involvement (Concise)

**CRITICAL Formula**:
```
New roles to suggest = (All roles from RoE that fit this deal) - (Roles already in "Twilio Team" section)
```

**Rules**:
- Read "Twilio Team" section first
- Determine which roles from RoE should be involved based on deal profile
- Suggest ONLY the roles NOT already listed in "Twilio Team"
- 1 sentence per NEW role explaining why needed
- Reference `reference/fy26_rules_of_engagement.md` for logic

**Decision logic** (use but don't document in output):
- **Small (<$50K)**: AE only
- **Medium ($50K-$200K)**: AE, SE, SSS
- **Large ($200K-$500K)**: + Value Engineer, consider Product Specialist
- **Strategic (>$500K)**: + Enterprise Strategist, Product Specialist, PS
- **Multi-product (3+)**: Product Specialist
- **Type 1**: Enterprise Strategist (EARLY)
- **Need business case**: Value Engineer
- **Custom integration**: Product Specialist or PS

**Output Format**:
```markdown
## Suggested Team Involvement

- **[Role]**: [One sentence why - based on deal size/complexity/stage]
```

**Example**:
```markdown
## Suggested Team Involvement

- **Product Specialist**: Multi-product solution (Voice + Messaging + Flex) requires specialist for architecture validation
- **Value Engineer**: $250K deal entering proposal stage - need business case for CFO approval
```

---

## ~~Suggest Next Steps for Stage Progression~~ (REMOVED)

**This section has been removed** - SE knows stage progression from training, no need to document in opp files.

---

## Post-Call Integration with /sf-artifacts Skill

**Workflow**:

1. User runs `/sf-artifacts` to generate USE CASE, RISKS, NOTES from call
2. `/sf-artifacts` outputs the three sections
3. User says: "Update opp SBES_IT accordingly" or "Add these notes to opp XYZ"

**Your Actions**:
1. Read current opp/account file
2. Extract from SF Artifacts and update:
   - **USE CASE**: Update "Use Case" section ONLY if significantly different (1-2 sentences max)
   - **RISKS**: Update "Risks" section - merge/add new risks with bold titles, reorder by priority
   - **NOTES**: Add to TOP of "Meeting Notes" with structured format (Recording, Attendees, Summary, Key Discussion Points, Action Items, Next Steps, Quotes)
3. Update "Current State" - convert to bullet points reflecting latest status
4. Update "Open Items / Next Steps" - actionable items with clear ownership using format: `- [ ] **[Owner]**: [Action]`
5. Move deferred items to "Pending / Later" section
6. Save file

**CRITICAL - No Duplication**:
- Deal size, stage, dates → SFDC only, NOT in opp file
- Risk mitigation plans → SF Artifacts only, NOT in opp file
- Technical details → Meeting Notes only, NOT duplicated in summary sections

**CRITICAL - Meeting Notes Structure**:
- Meeting Notes: newest date at TOP (reverse chronological)
- Never modify existing meeting notes entries, only prepend new ones
- Use structured format: Recording link, Attendees with roles, Summary (1-2 sentences), Key Discussion Points (by topic), Action Items (with owners)
- **Keep notes brief**: Maximum 4000 characters per meeting note
- **No quotes section** - capture decisions and context in Key Discussion Points instead
- Match length of existing meeting notes in the file (typically 2000-3000 characters)
- SF Artifacts are NOT stored in opp file - they're temporary files for Salesforce only

**Output to User**:
```markdown
✅ Updated opp/[name].md

Changes:
- Added meeting notes from [Date]
- Updated current state (bullet points)
- Updated open items with ownership
- Updated risks (reordered by priority)
- Moved [X] items to Pending / Later (if applicable)
```

---

## Usage Examples

**Example 1: Create New Opp**
```
User: Create new opp SBES_IT

You: I'll create a new opportunity. Is this Strategic Account or New Business?

User: New Business

You: [Ask questions, gather info, create file in opps/sbes_it.md]

Created opps/sbes_it.md.

Suggested Team Involvement:
- AE and SE sufficient for small deal
```

**Example 2: Update After Call**
```
User: Update opp SBES_IT with notes from call today

You: [Read opps/sbes_it.md, update from SF artifacts]

✅ Updated opps/sbes_it.md

Changes:
- Added meeting notes from 2026-06-15
- Updated current state
- Updated open items

Suggested Team Involvement:
- Enterprise Strategist: ServiceNow integration requires early involvement per RoE
```

**Example 3: Review Status**
```
User: Show me status of opp SBES_IT

You: [Read file, analyze]

# SBES IT Status

**Current State**: Technical Evaluation, Medium risk, close expected end of Q2

**Open Items**:
- [ ] Clarify POC duration
- [ ] Schedule technical deep dive

Suggested Team Involvement:
- Product Specialist: ServiceNow integration complexity
```

---

## Files to Reference

```markdown
## Next Steps to Progress Opportunity

**Current Presales Stage**: [Stage Number - Stage Name]
**Target Stage**: [Next Stage Name]

### Requirements to Reach [Target Stage]:

**Completed**:
- ✅ [Requirement that's met]

**Outstanding**:
- ❌ [Requirement not yet met] - **Action needed**: [Specific action]

### Recommended Actions (Priority Order):

1. **[Action]** - [Why this matters] - [Who should do it]
2. **[Action]** - [Why this matters] - [Who should do it]
3. **[Action]** - [Why this matters] - [Who should do it]

### Stage-Specific Guidance:

[Pull relevant guidance from tech win definition and engagement model]

### Estimated Timeline:

- [Milestone 1]: [Date]
- [Milestone 2]: [Date]
- Target [Next Stage]: [Date]

### Risks to Progression:

[Any risks that could prevent moving to next stage]
```

**Example Output**:
```markdown
## Next Steps to Progress Opportunity

**Current Presales Stage**: 3 - Technical Evaluation
**Target Stage**: 4 - Technical Win Achieved

### Requirements to Reach Technical Win Achieved:

**Completed**:
- ✅ Customer's selection criteria defined (PoC with live agent testing)
- ✅ Technical Owner identified (Sarah Chen, VP Engineering)
- ✅ PoC environment set up and tested

**Outstanding**:
- ❌ PoC validation with customer's agents - **Action needed**: Schedule PoC review session with Sarah's team
- ❌ Explicit confirmation from Technical Owner - **Action needed**: Get verbal/written confirmation from Sarah that PoC satisfied their requirements
- ❌ Launch plan defined - **Action needed**: Work with Sarah to document go-live timeline and milestones

### Recommended Actions (Priority Order):

1. **Schedule PoC Review Session** - Customer needs to validate PoC with their agents before Sarah can sign off - **AE to schedule with Sarah's team for next week**

2. **Address Open Technical Questions** - Three questions pending from their DevOps team about monitoring/alerting integration - **SE (Anton) to provide answers by Friday**

3. **Get Explicit Tech Win Confirmation** - Once PoC validated, get clear "yes" from Sarah - **AE + SE to ask: "Are you satisfied with the technical solution? Do you have what you need to say yes from a technical perspective?"**

4. **Define Launch Plan** - Work with Sarah to document phased rollout plan (pilot → full deployment) - **SE to draft, review with customer**

### Stage-Specific Guidance:

From Tech Win Definition:
- **Tech Win = Technical Owner confirms selection criteria satisfied + plan to launch exists**
- Don't assume customer is satisfied - get explicit confirmation
- The Technical Owner (Sarah) can't fully say "Yes" (still need legal/commercial) but has power to say "No"
- Document her confirmation in SE Notes

### Estimated Timeline:

- PoC Review Session: Next Week (target June 20)
- Technical Questions Answered: This Friday (June 16)
- Tech Win Confirmation: June 22-23 (after PoC review)
- Move to Technical Win Achieved: June 23

### Risks to Progression:

- **PoC validation delay**: Customer's agents availability for testing is limited - may push timeline
- **Technical Owner vacation**: Sarah mentioned potential vacation in July - need confirmation before she leaves
- **Open DevOps questions**: If answers don't satisfy DevOps team, may create blocker
```

---

## Post-Call Integration with /sf-artifacts Skill

**Workflow**:

1. User runs `/sf-artifacts` to generate USE CASE, RISKS, NOTES from call
2. `/sf-artifacts` outputs the three sections
3. User says: "Update opp SBES_IT accordingly" or "Add these notes to opp XYZ"

**Your Actions**:
1. Read current opp/account file
2. Extract from SF Artifacts and update:
   - **USE CASE**: Update "Use Case" section ONLY if significantly different (1-2 sentences max)
   - **RISKS**: Update "Risks" section - merge/add new risks (1 line each, NO mitigation plans)
   - **NOTES**: Add to TOP of "Meeting Notes" with today's date - PREPEND, don't append
3. Update "Current State" (2-3 sentences max, NO duplication of info elsewhere)
4. Update "Open Items / Next Steps" - actionable items only
5. **Suggest Team Involvement**: Check current "Twilio Team" section, suggest ONLY new roles (1 sentence each)
6. Save file

**CRITICAL - No Duplication**:
- Deal size, stage, dates → SFDC only, NOT in opp file
- Risk mitigation plans → SF Artifacts only, NOT in opp file
- Technical details → Meeting Notes only, NOT duplicated in summary sections
- Team involvement suggestions → Removed (SE decides, no need to document)
- Stage progression guidance → Removed (SE knows this, no need to document)

**CRITICAL - Meeting Notes Ordering**:
- Meeting Notes: newest date at TOP
- Never modify existing meeting notes entries, only prepend new ones
- SF Artifacts are NOT stored in opp file - they're temporary files for Salesforce only

**Output to User**:
```markdown
✅ Updated opp/[name].md

Changes:
- Added meeting notes from [Date]
- Updated current state (bullet points)
- Updated open items with ownership
- Updated risks (reordered by priority)
- Moved [X] items to Pending / Later (if applicable)
```

---

## Usage Examples

**Example 1: Create New Opp**
```
User: Create new opp SBES_IT

You: I'll create a new opportunity. Is this Strategic Account or New Business?

User: New Business

You: [Ask questions, gather info, create file in opps/sbes_it.md]

Created opps/sbes_it.md.

Based on the information provided:
- Deal size ($2-5K) = Small opportunity
- Presales Stage: Discovery

Suggested Team Involvement:
[Analysis based on deal profile]

Next Steps to reach Technical Evaluation:
[Guidance based on current stage]
```

**Example 2: Update After Call**
```
User: Update opp SBES_IT with notes from call today

[You read opps/sbes_it.md]

You: I'll update the opportunity. Can you provide the call notes or should I use the output from /sf-artifacts?

User: Use SF artifacts output I just generated

You: [Read SF artifacts output from previous turn, update file]

Updated opps/sbes_it.md:
- Added meeting notes from 2026-06-15
- Updated Technical Evaluation stage details
- Added 3 new risks
- Updated next steps

Suggested Team Involvement:
[New analysis - flags that Enterprise Strategist should be involved because ServiceNow integration is complex]

Next Steps:
[Shows what's needed to reach Tech Win]
```

**Example 3: Review Status**
```
User: Show me status of opp SBES_IT

You: [Read file, analyze current state]

# SBES IT Opportunity Status

**Current State**:
- Presales Stage: 3 - Technical Evaluation
- Risk Level: Medium
- Expected Close: End of Q2
- Last Interaction: 3 days ago

**Open Items**:
- [ ] Clarify POC duration (1 month vs 3 months)
- [ ] Confirm ServiceNow version
- [ ] Schedule technical deep dive

**Current Risks**:
- POC duration mismatch
- ServiceNow integration complexity unknown

---

**⚠️ Suggested Actions**:

You should consider involving:
- 🎯 Product Specialist: ServiceNow integration complexity requires specialist input

To progress to Technical Win Achieved, you need:
- ❌ Complete POC with customer
- ❌ Get explicit confirmation from Technical Owner
- ❌ Define launch plan

[Detailed next steps analysis]
```

---

## Key Principles

1. **Always Read Before Update**: Never update blindly
2. **Concise Output**: 30% of old size - no duplication
3. **No SFDC Field Duplication**: Deal size, stage, dates stay in SFDC, NOT in opp file
4. **Team Involvement**: Only suggest NEW roles not already involved (1 sentence each)
5. **Meeting Notes at Top**: Newest first, never modify existing entries
6. **User Decides**: Suggest, don't dictate

---

## Files to Reference

- **RoE**: `reference/fy26_rules_of_engagement.md` - Who to involve when
- **Tech Win**: `reference/tech_win_definition.md` - What Tech Win means, how to achieve it
- **Engagement Model**: `reference/se_engagement_model.md` - Presales stages, expectations
