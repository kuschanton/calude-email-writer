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
   - Current State
   - Open Items / Next Steps
   - Meeting Notes (append new entry with date)
   - Products (if new products mentioned)
   - Risks (if new risks identified)
4. **Suggest Involvement** (see section below)
5. **Suggest Next Steps for Stage Progression** (see section below)
6. Save updated file
7. Show user diff of what changed

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
- Status: [Discovery / Technical Evaluation / Active / etc.]
- Last interaction: [Date]
- Primary use cases: [List]

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

## Current State
- Presales Stage: [1-Qualified / 2-Discovery / 3-Technical Evaluation / 4-Technical Win Achieved / X-Technical Loss]
- Sales Stage: [SFDC stage]
- Risk Level: [None / Low / Medium / High / Critical]
- Status: [Active / Stalled / Blocked]
- Last interaction: [Date]

## Company Info
- **Company**: [Name]
- **Industry**: [Industry]
- **Size**: [Employee count / revenue]
- **Location**: [HQ location]
- **Website**: [URL if known]

## Opportunity Details
- **Expected Close**: [Date]
- **ACV / iACV**: $[amount]
- **Deal Type**: [New Logo / Expansion / Migration]
- **Competition**: [Competitors if known]

## Use Case

[Detailed description of what customer is trying to achieve]

**Business Problem**:
[What pain point are they solving?]

**Proposed Twilio Solution**:
[How Twilio addresses the need]

## Products
- [Product 1]
- [Product 2]
- [Product 3]

## Technical Requirements
- [Requirement 1]
- [Requirement 2]

## Open Items / Next Steps
- [ ] [Action item 1]
- [ ] [Action item 2]

## Suggested Team Involvement

[Auto-generated based on presales stage, deal size, complexity - see "Suggest Involvement" section below]

## Customer Team
- [Name] - [Role] - [Email] - [Technical Owner? Champion?]

## Twilio Team
- [AE Name] - AE
- Anton Kushch - SE
- [Other roles as needed]

## Technical Risks & Challenges

### Risk Level: [None / Low / Medium / High / Critical]

[List of risks with mitigation plans - can be populated from SF Artifacts RISKS section]

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

---

## SF Artifacts History

### [Date] - Post-Call Notes

[Can paste USE CASE, RISKS, NOTES from `/sf-artifacts` output here for reference]
```

---

## Suggest Team Involvement

**Critical**: Always include this section when updating an opportunity. This is one of the key value-adds of this skill.

**Reference Documentation**: `reference/fy26_rules_of_engagement.md`

**Logic**:

### Step 1: Analyze Current State
- Presales Stage
- Deal Size (ACV/iACV)
- Products involved (count and complexity)
- Technical requirements
- Current team members already involved

### Step 2: Determine Who Should Be Involved

Use this decision tree:

#### Always Involved:
- **AE**: Always on every opportunity
- **SE (Anton)**: If New Business >$50K iACV, or any Strategic opportunity

#### Based on Deal Size:
- **Small (<$50K)**: AE only, maybe SDR for pipeline
- **Medium ($50K-$200K)**: AE, SE, SSS (for quotes)
- **Large ($200K-$500K)**: AE, SE, Value Engineer, SSS, consider Product Specialist
- **Strategic (>$500K)**: AE, SE, Enterprise Strategist, Value Engineer, Product Specialist, PS scoping

#### Based on Complexity:
- **Multi-product (3+ products)**: Product Specialist
- **Type 1 (complex multi-product + custom architecture)**: Enterprise Strategist (EARLY), Product Specialist
- **Custom integrations**: Product Specialist, potentially PS
- **Legacy system migration**: PS, potentially Partners

#### Based on Stage:
- **Discovery**: Consider Value Engineer if large deal, Enterprise Strategist if Type 1
- **Technical Evaluation**: Product Specialist if multi-product, PS if PoC build needed
- **Submit Proposal**: SSS for quotes, Value Engineer for business case
- **Closed Won**: PS for implementation, Enterprise Architect for HLD, Partners if SI needed

#### Based on Customer Situation:
- **Need business case / ROI**: Value Engineer
- **Executive buy-in lacking**: Enterprise Strategist, Value Engineer
- **Customer lacks dev resources**: PS, Partners Alliance Manager
- **Competitive displacement**: Value Engineer, Product Specialist
- **Partner/SI involvement**: Partners Alliance Manager, Partner Solutions Architect
- **Compliance/Security heavy**: Flag in notes, SE to lead

#### Based on Products:
- **Flex**: Consider Enterprise Strategist (complex), PS for implementation
- **Multiple products with integration**: Product Specialist
- **Beta/Incubation products**: GTM Innovation

### Step 3: Format Suggestion

**Output Format**:
```markdown
## Suggested Team Involvement

Based on current stage ([Stage]) and deal profile ([size/complexity]):

### Already Involved:
- ✅ [Name] - [Role]

### Recommended to Involve:
- 🎯 **[Role] - [Name if known]**: [WHY - specific reason based on deal profile]
  - **When**: [Now / At [Stage] / Before [Milestone]]
  - **For**: [Specific contribution they will make]

### Consider for Future:
- 💡 **[Role]**: [WHY - conditional reason]
  - **Trigger**: [What would make this necessary]

### Notes:
- [Any specific guidance from RoE that applies]
- [Any flags or considerations]
```

**Example Output**:
```markdown
## Suggested Team Involvement

Based on current stage (Technical Evaluation) and deal profile ($250K iACV, multi-product, Type 1 complexity):

### Already Involved:
- ✅ Marc Gonzales - AE
- ✅ Anton Kushch - SE

### Recommended to Involve:
- 🎯 **Enterprise Strategist**: Deal is Type 1 (Flex + Voice + Messaging + ServiceNow integration)
  - **When**: NOW - Enterprise Strategist should be involved EARLY for Type 1 opportunities
  - **For**: Complex discovery, architecture validation, executive stakeholder management

- 🎯 **Value Engineer**: $250K deal, customer has asked about ROI
  - **When**: Before Submit Proposal stage
  - **For**: Build business case / ROI model for CFO approval

- 🎯 **Product Specialist**: Multi-product solution with complex dependencies
  - **When**: During Technical Evaluation (now)
  - **For**: Solution architecture across Flex, Voice, Messaging - ensure products integrate properly

### Consider for Future:
- 💡 **Professional Services**: Customer mentioned limited internal dev resources
  - **Trigger**: If Tech Win achieved, involve PS for implementation scoping

- 💡 **Partners Alliance Manager**: ServiceNow integration is complex
  - **Trigger**: If customer prefers SI to lead implementation vs. Twilio PS

### Notes:
- Per RoE: Type 1 opportunities require Enterprise Strategist involvement EARLY
- Deal size ($250K) falls into "Large" category - Value Engineer recommended
- Multi-product = Product Specialist is standard involvement
```

---

## Suggest Next Steps for Stage Progression

**Reference Documentation**: 
- `reference/tech_win_definition.md`
- `reference/se_engagement_model.md`

**Purpose**: Proactively tell user what needs to happen to move opportunity to next presales stage.

### Presales Stage Definitions (Reminder)

**Stage 1: Qualified**
- There is identified need and path to closing opportunity
- Opportunity MEDDPICC-ing happening

**Stage 2: Discovery**
- Research, refine use cases, ask questions
- End result: proposed solution

**Stage 3: Technical Evaluation**
- Determine evaluation criteria, educate, answer questions, assist with PoC
- Customer actively evaluating Twilio

**Stage 4: Technical Win Achieved**
- Technical Owner confident in moving forward with specific Twilio solution
- Has plan to launch
- Tech Owner can say "No" but is saying "Yes"
- Selection criteria satisfied (demo/PoC/pilot/RFP/etc.)

**Stage X: Technical Loss**
- Tech win not achieved
- Risks and Solution Gaps documented

---

### Next Steps Logic by Current Stage

#### If Stage = 1 (Qualified):

**To progress to Discovery, you need**:
- ✅ Opportunity exists in SFDC
- ✅ 3 WHYs answered (Why now? Why anything? Why Twilio?)
- ✅ Use case identified
- ✅ Technical stakeholders identified (even if not met yet)
- ✅ Path to closing defined

**Missing items**:
[Check what's missing from above list, flag it]

**Next Steps to Reach Discovery**:
- Schedule discovery call with technical stakeholders
- Prepare discovery questions (MEDDPICC)
- Understand customer's technical environment
- Define proposed solution approach

---

#### If Stage = 2 (Discovery):

**To progress to Technical Evaluation, you need**:
- ✅ Technical requirements documented
- ✅ Customer's technical environment understood
- ✅ Proposed Twilio solution drafted
- ✅ Key stakeholders identified (Technical Owner, Champion, etc.)
- ✅ Customer's evaluation criteria understood
- ✅ Integration points / architecture approach defined

**Missing items**:
[Check what's missing from above list, flag it]

**Next Steps to Reach Technical Evaluation**:
- Present proposed solution to customer
- Understand customer's selection criteria (what will make them say "yes"?)
- Define evaluation plan (demo? PoC? RFP response? Architecture review?)
- Schedule demo/PoC/technical validation session
- Identify Technical Owner (person who can say "No")

---

#### If Stage = 3 (Technical Evaluation):

**To progress to Technical Win Achieved, you need**:
- ✅ Customer's selection criteria clearly defined
- ✅ Technical Owner identified (person with veto power)
- ✅ Evaluation method executed (demo / PoC / RFP / architecture review / pilot)
- ✅ Technical concerns/objections addressed
- ✅ Explicit confirmation from Technical Owner that criteria satisfied
- ✅ Plan to launch defined

**Missing items**:
[Check what's missing from above list, flag it]

**Next Steps to Reach Technical Win Achieved**:
- Complete customer's evaluation (PoC/demo/RFP/etc.)
- Address all open technical questions/concerns
- Get explicit confirmation from Technical Owner:
  - "Are you satisfied with the technical solution?"
  - "Do you have what you need to say 'yes' from a technical perspective?"
  - "What's the plan to launch?"
- Document Technical Owner's confirmation
- Create launch/implementation plan with customer
- Prepare for handoff to PS (if needed)

**Remember**: Tech Win = Technical Owner confirms selection criteria satisfied + plan to launch exists

---

#### If Stage = 4 (Technical Win Achieved):

**You are at Technical Win! Next Steps**:
- Move opportunity to Sales Stage: "Submit Proposal" or "Negotiation"
- Work with SSS to generate quote/order form
- If large/complex: Prepare HLD (High Level Design) for PS handoff
- If PS needed: Scope PS engagement, involve PS team
- If Partners needed: Involve Partners Alliance Manager for SI coordination
- Await commercial/legal/financial wins to close deal

**Post-Closed Won**:
- Handoff to PS with HLD
- Introduce TAM (if strategic account)
- Schedule implementation kick-off

---

#### If Stage = X (Technical Loss):

**You are at Technical Loss. Post-mortem**:
- Document why tech win was not achieved
- What risks materialized?
- What solution gaps existed?
- What could we have done differently?
- Lessons learned for future opportunities

---

### Output Format for Next Steps

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
2. Extract relevant info from SF Artifacts output:
   - **USE CASE**: Update "Use Case" section if more detail than current
   - **RISKS**: Append to "Technical Risks & Challenges" section (don't duplicate)
   - **NOTES**: Add to "Meeting Notes" with today's date
3. Append SF Artifacts to "SF Artifacts History" section for reference
4. Update "Current State" if stage changed
5. Update "Open Items / Next Steps" based on action items from NOTES
6. **Run "Suggest Team Involvement" logic** based on updated information
7. **Run "Next Steps for Stage Progression" logic**
8. Save file
9. Show user what was updated

**Output to User**:
```markdown
Updated opp/[name].md with post-call notes.

### Changes Made:
- ✅ Added meeting notes from [Date]
- ✅ Updated risks section with 2 new risks
- ✅ Updated open items with 5 action items
- ✅ Appended SF Artifacts to history

### Team Involvement Suggestions:
[Output from "Suggest Involvement" section]

### Next Steps to Progress:
[Output from "Next Steps for Stage Progression" section]
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

1. **Always Read Before Update**: Never update blindly, always read current state first
2. **Proactive Suggestions**: Always suggest team involvement and next steps when updating
3. **Reference Documentation**: Use RoE, Tech Win Definition, and Engagement Model docs
4. **Context-Aware**: Tailor suggestions to specific deal profile (size, stage, complexity)
5. **Actionable**: Make suggestions specific and actionable, not generic
6. **User Decides**: Suggest, don't dictate - user always makes final call on involvement
7. **Track History**: Maintain meeting notes and SF Artifacts history for context

---

## Files to Reference

- **RoE**: `reference/fy26_rules_of_engagement.md` - Who to involve when
- **Tech Win**: `reference/tech_win_definition.md` - What Tech Win means, how to achieve it
- **Engagement Model**: `reference/se_engagement_model.md` - Presales stages, expectations
