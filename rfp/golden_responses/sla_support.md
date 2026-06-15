# SLA / Support

Golden responses for SLA / Support-related RFX questions.

---

## Q37: What is your committed SLA for Service Availability and Mean Time to Repair (MTTR) for each type of ...

**Full Question**: What is your committed SLA for Service Availability and Mean Time to Repair (MTTR) for each type of incident?

**Importance**: Critical

**Answer**:

Twilio's support SLAs vary by support plan. There are no committed MTTR (Mean Time to Repair) guarantees - only guaranteed response times. Resolution time depends on factors outside Twilio's direct control, including third-party carrier responses and the complexity of multi-carrier routing scenarios inherent to global telecommunications infrastructure.

Developer Plan (included):
- No guaranteed response times
- Standard support via Help Center and community

Business Plan:
- Business critical (P1): 1 hour response (24/7)
- Degraded service (P2): 2 business hours response
- General issues (P3): 3 business hours response
- Includes technical account manager, escalation line, phone support

Personalized Plan:
- Same response time SLAs as Business
- Dedicated support team with Technical Account Manager (TAM)

SLA credits apply when guaranteed response times are not met. Details available in the support plans documentation.

For Richemont's global deployment spanning 50+ countries with 1,000+ numbers, we strongly recommend Personalized Support. The key advantage is your dedicated Technical Account Manager who serves as a single point of contact, understands your unique architecture and traffic patterns, maintains deep knowledge of your multi-country setup, and provides proactive guidance. When incidents occur - especially complex multi-region carrier issues - your TAM coordinates resolution across Twilio teams and carriers, eliminating the need to re-explain your environment with each ticket. This becomes critical when managing global telephony infrastructure where regional issues require rapid, coordinated response.

More information: https://www.twilio.com/en-us/support-plans

---

## Q38: Is Tier-2/Tier-3 technical support available 24/7/365? Is it "Follow-the-Sun"?

**Full Question**: Is Tier-2/Tier-3 technical support available 24/7/365? Is it "Follow-the-Sun"?

**Importance**: High

**Answer**:

Yes. Twilio provides 24/7/365 support for Business Critical (P1) and Degraded Service (P2) incidents on Business and Personalized support plans, with guaranteed 1-hour and 2-hour response times respectively.

Twilio operates a "follow-the-sun" support model with teams working standard business hours (9 AM - 6 PM, Monday-Friday) across multiple countries in the Americas, EMEA, and APAC regions. This ensures continuous global coverage and allows customers to receive support during their local business hours.

For P1 (Business Critical) issues, 24/7 escalation is available regardless of weekends or local holidays. Tier-2 and Tier-3 technical engineers are available around the clock for critical incidents, with automatic escalation paths built into the support workflow.

The follow-the-sun model ensures that as one region ends its business day, support responsibility seamlessly transitions to the next region, providing continuous coverage without relying on a single team working overnight shifts.

More information: https://www.twilio.com/en-us/support-plans
Business hours: https://help.twilio.com/articles/223136127-Twilio-Support-business-hours

---

## Q39: How do you support your client for identifying the call quality issues?

**Full Question**: How do you support your client for identifying the call quality issues?

**Importance**: High

**Answer**:

Twilio provides comprehensive tools and support for identifying call quality issues:

Voice Insights:
- Real-time call quality monitoring with MOS scores, jitter, packet loss, and round-trip time metrics
- Automatic flagging of calls with quality issues (highlighted in red in Console Call Logs)
- Per-leg metrics to pinpoint where degradation occurs (SIP edge, carrier edge)
- Time-series graphs showing quality trends throughout call duration
- Root cause analysis identifying network vs. carrier vs. configuration issues

Proactive Monitoring:
- Automatic quality alerts triggered when metrics breach ITU-T thresholds
- Debugger alerts for SIP errors and call failures
- Trust & Engagement Insights monitoring answer rates and spam flagging trends

Support Team Assistance:
- Technical Account Managers (Personalized Plan) provide proactive analysis of quality trends
- Support engineers use Voice Insights data to diagnose issues during troubleshooting
- Escalation to carrier relationships team for carrier-side quality issues
- Periodic account reviews identifying patterns and recommending optimizations

Diagnostic Tools:
- SIP packet captures (PCAPs) for detailed signaling analysis
- Call logs with SIP response codes and error details
- API access to quality metrics for integration with customer monitoring systems

The combination of automated detection, comprehensive diagnostics, and expert support enables rapid identification and resolution of quality issues.

More information: https://www.twilio.com/docs/voice/voice-insights

---

## Q40: If in a country you are not a direct carrier, how you manage the issues with the underlying carrier?

**Full Question**: If in a country you are not a direct carrier, how you manage the issues with the underlying carrier?

**Importance**: High

**Answer**:

In countries where Twilio uses aggregator or partner carriers rather than direct connections, carrier issues are managed through:

Dedicated Carrier Operations Team:
- Direct escalation channels with aggregator and carrier partners
- SLAs with carrier partners defining response expectations
- 24/7 Network Operations Center monitoring all carrier routes

Automated Response:
- Super Network automatically detects carrier degradation and reroutes traffic within microseconds
- 4+ carrier routes per destination provide redundancy when one carrier experiences issues

Issue Resolution:
- Support engineers escalate carrier-specific issues directly to carrier technical teams
- Twilio coordinates resolution and provides status updates to customers
- Root cause analysis shared after resolution

This ensures carrier issues in aggregator markets are resolved quickly with minimal customer impact through automatic failover and direct carrier engagement.

---

## Q41: If the issue is not coming from your network/underlying carrier network, how would you assist us to ...

**Full Question**: If the issue is not coming from your network/underlying carrier network, how would you assist us to identify the root cause of the issue?

**Importance**: High

**Answer**:

When issues originate outside Twilio's network, our support team provides diagnostic assistance to identify the root cause:

Diagnostic Tools:
- Voice Insights per-leg metrics to isolate where issues occur
- SIP packet captures (PCAPs) for detailed signaling analysis
- Call logs with SIP response codes and error details
- RTC Diagnostics SDK for network connectivity and quality testing
- Preflight API for pre-call device and network validation

Support Assistance:
- Analysis of customer-side configuration and network topology
- Guidance on resolving customer infrastructure issues
- Escalation to specialized engineering teams when needed
- Best practices and recommendations for optimal configuration

This enables customers to quickly identify and resolve issues in their own infrastructure with Twilio's diagnostic tools and support expertise.

---

## Q42: What is your Root Cause Analysis (RCA) process for each Priority/type of incident

**Full Question**: What is your Root Cause Analysis (RCA) process for each Priority/type of incident

**Importance**: High

**Answer**:

Twilio’s Root Cause Analysis (RCA) Process by Incident Priority

Twilio follows a structured and thorough RCA process for all incidents, tailored to the severity and priority of each event. Our approach ensures rapid containment, detailed investigation, and long-term prevention. The process includes:

1. Immediate Response & Containment
For critical (Sev 0/P1) incidents, we initiate immediate investigation and containment to minimize impact.
Actions may include revoking credentials, suspending affected services, and communicating with stakeholders.
2. Incident Timeline & Impact Assessment
We build a detailed timeline, documenting when the incident began, was detected, and resolved, including all key actions and communications.
The impact is assessed (financial, operational, reputational, or regulatory), and affected customers are identified.
3. Root Cause Identification
We gather and correlate logs from Twilio systems and customer applications.
The “5 Whys” technique is used to drill down to the underlying cause (e.g., credential exposure, misconfiguration, or process gaps).
For fraud or abuse, we analyze specific vectors such as unauthorized access, weak authentication, or regulatory non-compliance.
4. Corrective & Preventive Actions
We document and implement both immediate fixes and long-term improvements (e.g., credential rotation, code refactoring, policy updates, enhanced monitoring).
For regulatory or carrier-related incidents, we coordinate with carriers and regulators, update policies, and request retesting as needed.
5. Documentation & Communication
A formal RCA report is created, summarizing the incident, root cause, actions taken, and future prevention steps.
For high-priority incidents, we provide Reason For Outage (RFO) documentation to affected customers upon request.
Continuous updates are provided throughout the process, and post-incident reviews are conducted to share learnings.
6. Ongoing Monitoring & Improvement
We monitor for recurrence and verify the effectiveness of corrective actions.
Lessons learned are incorporated into our processes, and employees are trained on updated best practices.
Severity/Priority Handling:

Sev 0/P1 (Critical): Immediate escalation, executive notification, and 24x7 response. Full RCA and RFO documentation provided.
Lower Priority: Standard RCA process with appropriate urgency and communication.

---

## Q43: How do you ensure continuous improvement?

**Full Question**: How do you ensure continuous improvement?

**Importance**: Medium

**Answer**:

Twilio is committed to a culture of continuous improvement across our products, services, and customer engagements. We achieve this through several key practices:

Data-Driven Insights: We provide customers with real-time analytics and actionable insights (e.g., Voice Insights, Messaging Insights) to monitor performance and identify opportunities for optimization. This transparency enables both Twilio and our customers to proactively address issues and enhance outcomes.

Customer Feedback Loops: We regularly solicit and incorporate customer feedback through surveys, support interactions, and business reviews. This feedback directly informs our product roadmap and service enhancements.

Iterative Product Development: Twilio employs agile methodologies, releasing frequent updates and enhancements based on customer needs, industry trends, and emerging technologies.

Proactive Monitoring & Governance: Our systems continuously monitor for anomalies, deliverability, and quality issues. We use this data to drive rapid improvements and maintain high standards of reliability and security.

Collaboration & Best Practices: We partner closely with customers to understand their evolving needs and share best practices, ensuring our solutions continue to deliver value as their business grows.

Continuous Enablement: Twilio’s enablement resources, such as our Innovators Report and customer success stories, showcase how organizations leverage our platform for ongoing improvement and innovation.

This approach ensures that Twilio not only meets but exceeds customer expectations, adapting to new challenges and opportunities as they arise.

---

## Q44: Please describe your global escalation process and the resources involved.

**Full Question**: Please describe your global escalation process and the resources involved.

**Importance**: Medium

**Answer**:

Twilio provides a structured global escalation process with multiple levels of support based on the support plan:

Priority-Based Escalation:
- Priority 1 (Business Critical): Complete loss of service, no workaround
- Priority 2 (Degraded Service): Intermittent issues, reduced quality
- Priority 3 (General Issue): Product questions, feature requests

Escalation Mechanisms:

Standard Escalation:
- Escalation feature available through Twilio Help Center
- Raises ticket priority for faster response
- Can be used to escalate issues requiring urgent attention

Personalized Support Plan (Recommended):
- Dedicated Technical Account Manager (TAM) manages the entire escalation process
- TAM serves as single point of contact for all escalations
- Direct access to Support Duty Manager Escalation line (24/7 on-call)
- TAM coordinates across engineering teams, carrier operations, and product teams

Global Resources:
- 24/7 follow-the-sun support coverage across Americas, EMEA, and APAC
- Cross-functional teams including Support Engineering, Carrier Operations, and Product Engineering
- Escalation to specialized teams based on issue type (carrier issues, platform issues, configuration issues)

For global deployments like Richemont's, the TAM-led escalation ensures coordinated response across multiple regions and carriers without requiring repeated explanations.

---

## Q45: What is your customer success process ? What are the type of reviews you do with your customers ? Pr...

**Full Question**: What is your customer success process ? What are the type of reviews you do with your customers ? Provide typical agenda and the participants to the meeting.

**Importance**: Medium

**Answer**:

Twilio's customer success process is led by Technical Account Managers (TAMs) who serve as strategic partners to maximize platform value and ensure alignment with business goals.

Key Elements:

Onboarding & Enablement:
- Technical setup and knowledge transfer
- Architecture guidance and best practices

Proactive Monitoring:
- Regular monitoring of usage, quality metrics, and KPIs
- Identification of optimization opportunities and risk mitigation

Strategic Reviews:
- Quarterly Business Reviews (QBRs) to discuss progress, challenges, and future plans
- Health Checks focused on usage, deliverability, and operational metrics
- Post-incident reviews following major incidents

Issue Resolution:
- TAM acts as escalation point for complex technical issues
- Coordination with engineering and carrier operations teams

Roadmap Alignment:
- Product updates and roadmap insights shared
- Planning for future growth and feature adoption

Quarterly Business Review (QBR) Agenda:
- Review of accomplishments and work in progress
- Current state vs. desired state analysis
- Health check: usage, quality metrics, incident trends
- Twilio roadmap updates and new capabilities
- Optimization recommendations
- Action items and next steps

Typical Participants:
- Twilio: TAM, Account Executive (AE), Solution Engineers, Product Specialists, Executive Sponsor (as needed)
- Customer: Technical leads, business stakeholders, project managers, executive sponsor (as needed)

This TAM-led approach provides proactive, strategic guidance tailored to customer needs.

---

## Q46: In the event of a PCI PAL call issue, Genesys provide a PCI PAL app foundry. However, please clarify...

**Full Question**: In the event of a PCI PAL call issue, Genesys provide a PCI PAL app foundry. However, please clarify the support process between your support team and Genesys support as there is a dependency with the phone number to make a secure session and use digits.

**Importance**: High

**Answer**:

Twilio and Genesys maintain a collaborative support process for PCI PAL issues, ensuring dependencies on phone numbers and secure sessions are resolved efficiently.

Support Process:

Issue Identification:
- Customer identifies PCI PAL call issue (secure session not established, digits not captured)
- Issue logged with Genesys Support referencing PCI PAL app and affected phone number

Triage and Escalation:
- Genesys Support triages issue and determines root cause
- If telephony-related (phone number configuration, session setup, digit transmission), escalates to Twilio Support
- Escalation includes all relevant logs, call details, and troubleshooting steps already performed

Collaborative Resolution:
- Twilio Support investigates phone number configuration, SIP trunking setup, and DTMF transmission
- Both teams maintain open communication, sharing logs and diagnostics
- Coordinated troubleshooting ensures secure session establishment and proper digit handling

Communication:
- Customer receives coordinated updates from both support teams
- Single point of contact maintained (typically Genesys for app issues, Twilio for telephony)
- Clear escalation paths defined for urgent cases

Key Considerations:
- Phone number configuration is critical for secure PCI PAL sessions
- Twilio provides detailed call logs, SIP traces, and Voice Insights data to support investigation
- Established partnership between Genesys and Twilio ensures rapid cross-platform issue resolution

This collaborative approach ensures customers receive integrated troubleshooting without being caught between vendors.

---

## Q47: How do you handle a carrier regional outage (e.g. our Japane phone lines are down)? Please describe ...

**Full Question**: How do you handle a carrier regional outage (e.g. our Japane phone lines are down)? Please describe the failover mechanisms you can implement.

**Importance**: Critical

**Answer**:

Twilio handles regional carrier outages through automatic failover mechanisms and proactive incident management.

Incident Detection and Response:

Automatic Detection:
- 24/7 Network Operations Center (NOC) continuously monitors carrier connectivity and call quality globally
- Real-time anomaly detection identifies carrier degradation or outages within microseconds
- Immediate investigation initiated upon detection

Communication:
- Status updates published via status.twilio.com
- Direct customer notifications for affected accounts
- TAM-led communication for Personalized Support customers

Failover Mechanisms:

Automatic Carrier Redundancy:
- Super Network maintains 4+ carrier routes per destination
- Automatic traffic rerouting to alternative carriers when primary carrier fails
- Rerouting occurs within microseconds without customer intervention

Dynamic Routing:
- Real-time selection of best available carrier path
- Continuous quality monitoring across 4,800+ carrier connections
- Traffic automatically diverted away from degraded or failed carriers

Geo-Redundant Infrastructure:
- Cloud infrastructure distributed across multiple regions
- Service continuity maintained even during regional infrastructure issues

Customer-Controlled Failover:
- Custom failover logic configurable via Twilio APIs
- Backup SIP endpoints or phone numbers in alternate regions
- Fallback workflows (redirect to IVR, alternate country numbers)

This multi-layered approach minimizes customer impact during carrier outages through automatic failover and diverse carrier relationships.

---

## Q48: What is the minimum requirments to open an incident (Ex: 1 call ID minimum) ? For our CRCs, it is ke...

**Full Question**: What is the minimum requirments to open an incident (Ex: 1 call ID minimum) ? For our CRCs, it is key to identify the root cause of each call.

**Importance**: Critical

**Answer**:

Minimum Requirements to Open an Incident

To open an incident with Twilio Support, the minimum requirement is typically at least one affected call SID (unique call identifier).

Providing a call SID allows Twilio to investigate the specific call flow, analyze logs, and identify the root cause efficiently.

For best results, include as much detail as possible: call SID(s), timestamps (in UTC), affected phone numbers, error messages, and a description of the issue.

This approach enables Twilio to perform targeted troubleshooting and root cause analysis for each call, which is especially important for environments like CRCs (Contact Routing Centers) where call-level traceability is critical.

Summary:
- Minimum requirement: 1 call SID (call ID) per incident
- More details (multiple call SIDs, logs, error messages) will help accelerate root cause identification and resolution

---

