# Analysis

Golden responses for Analysis-related RFX questions.

---

## Q25: Do you provide a reporting platform? What are its features

**Full Question**: Do you provide a reporting platform? What are its features

**Importance**: High

**Answer**:

Yes. Twilio provides comprehensive voice reporting through Voice Insights and Voice Logs:

Voice Insights offers call quality analytics and reporting with real-time dashboards showing call volume, quality metrics (MOS, jitter, packet loss), connectivity issues, and performance trends. Features include per-call summaries with detailed quality data, aggregate dashboards for trend analysis, time-series views of quality metrics, event streams for real-time monitoring, and SIP error code reporting for troubleshooting.

Voice Logs provide detailed call records with searchable logs of all voice activity, call metadata (duration, direction, status), debugging information, and webhook logs for troubleshooting integration issues.

Both platforms support data export capabilities, REST API access for programmatic reporting, customizable date ranges and filters, drill-down analysis from aggregate to individual calls, and integration with business intelligence tools. Reports can be accessed through Console dashboards or retrieved via API for custom analytics pipelines.

More information: https://www.twilio.com/docs/voice/voice-insights

---

## Q26: Do you provide specific SIP Error Code reporting (e.g., 404, 480, 503) to identify failure points?

**Full Question**: Do you provide specific SIP Error Code reporting (e.g., 404, 480, 503) to identify failure points?

**Importance**: High

**Answer**:

Yes. Twilio provides SIP error code reporting through Voice Insights Call Summary, accessible via Console Call Logs or REST API. For each call, the "Last SIP Response" field displays the specific SIP response code received (e.g., 404 Not Found, 480 Temporarily Unavailable, 503 Service Unavailable).

Common SIP response codes documented include 401/407 (authentication), 403 (forbidden), 404 (not found), 480 (temporarily unavailable), 486 (busy), and 503 (service unavailable). These codes help identify failure points such as invalid destinations, busy endpoints, authentication issues, or carrier rejections.

Additionally, SIP packet captures (PCAPs) are available for 14 days in Console Call Logs, allowing detailed inspection of full SIP signaling traces including all response codes exchanged during call setup and teardown.

---

## Q27: What are your key voice quality and performance metrics?

**Full Question**: What are your key voice quality and performance metrics?

**Importance**: High

**Answer**:

Twilio tracks comprehensive voice quality and performance metrics through Voice Insights:

Call Quality Metrics:
- Mean Opinion Score (MOS): 1-5 scale measuring overall call quality (>4.2 is good, <3.5 is poor), calculated from jitter, packet loss, and round-trip time
- Jitter: Variation in packet arrival times, measured in milliseconds
- Packet Loss: Percentage of lost voice packets
- Round-Trip Time (RTT): Latency measurement for two-way audio delay
- Audio Levels: Input/output audio levels for volume troubleshooting

Performance Metrics:
- Post-Dial Delay (PDD): Time from call initiation to ring
- Call Duration and Connection Time
- Codec Information (typically PCMU/G.711)
- Answered Seizure Ratio (ASR): Percentage of successfully connected calls
- Average Call Duration (ACD)

All metrics are available through real-time dashboards, per-call summaries, time-series views (collected every second for SDK calls, every 10 seconds for carrier calls), and programmatic access via REST API.

---

## Q28: What are your key call delivery failure metrics?

**Full Question**: What are your key call delivery failure metrics?

**Importance**: High

**Answer**:

Twilio tracks comprehensive call delivery failure metrics through Voice Insights:

Failure Status Categories:
- Failed: Carrier could not connect the call (unreachable destination, invalid number)
- Busy: Destination returned busy signal
- No-Answer: Call rang but was not answered before timeout
- Canceled: Call disconnected by calling party before answer

Key Performance Indicators:
- Connection Rate: Percentage of calls that successfully reached the destination (excludes canceled and failed calls)
- Answer Seizure Ratio (ASR): Percentage of attempted calls that were successfully answered
- High Post-Dial Delay (PDD): Calls with excessive delay between dial and ring (>6 seconds)
- Network Affected: Calls impacted by packet loss, jitter, or latency issues

Failure Analysis:
- SIP Response Codes: Specific error codes identifying failure points (403, 404, 480, 503, etc.)
- Who Hung Up: Distinguishes caller vs. callee disconnections vs. SIP errors
- Call State: Terminal status for each call attempt

All metrics available via Console dashboards, Call Logs, and REST API for trend analysis and troubleshooting.

---

## Q29: What are your acceptable thresholds (%) for the previously mentionned metrics? Ex: Call delivery fai...

**Full Question**: What are your acceptable thresholds (%) for the previously mentionned metrics? Ex: Call delivery failure %. MOS score above 4.5.

**Importance**: Medium

**Answer**:

Twilio monitors voice quality using the following thresholds based on ITU-T standards:

Mean Opinion Score (MOS):
- Excellent: 4.3-4.5
- Unacceptable: Below 3.5
Source: https://www.twilio.com/docs/glossary/what-is-mean-opinion-score-mos 

Jitter:
- Threshold: 30ms (based on ITU-T standards)
Source: https://www.twilio.com/docs/voice/voice-insights/advanced-features 

Post-Dial Delay (PDD):
- High PDD threshold: 6 seconds
Source: https://help.twilio.com/articles/360035018373-View-the-Voice-Insights-Summary-for-a-Call 

Answer Seizure Ratio (ASR):
- Required minimum: Greater than 70% for enterprise traffic profiles
Source: https://www.twilio.com/docs/sip-trunking/cps-trunk-termination 

Packet Loss:
- Warning threshold: Greater than 1%
Source: https://www.twilio.com/docs/voice/voice-insights/api/call/details-sdk-call-quality-events

Voice Insights automatically monitors these metrics and triggers alerts when thresholds are breached.

---

## Q30: What is the process for ordering new numbers and decommissioning numbers within your system?

**Full Question**: What is the process for ordering new numbers and decommissioning numbers within your system?

**Importance**: Medium

**Answer**:

Twilio provides three methods for ordering and decommissioning phone numbers:

Ordering:
- Console: Web-based search and purchase of available numbers by country, number type, and area code
- REST API: Programmatic search and provisioning for automated, large-scale deployments
- Private Offering Form: For bulk orders, complex requirements, or special number requests through Twilio Support team

Decommissioning:
- Console: Select and release numbers individually through the Active Numbers page
- REST API: Programmatic deletion for bulk decommissioning operations
- Support: Assistance with large-scale decommissioning projects

All methods require regulatory compliance documentation (Address SID, Bundle SID) for regulated countries. Released numbers enter a 10-day reclaim window before permanent release.

More information: https://www.twilio.com/docs/phone-numbers
API reference: https://www.twilio.com/docs/phone-numbers/api/incomingphonenumber-resource

---

## Q31: What is the process for connecting and removing those numbers into Genesys?

**Full Question**: What is the process for connecting and removing those numbers into Genesys?

**Importance**: Medium

**Answer**:

Twilio Elastic SIP Trunking integrates with Genesys Cloud via the BYOC (Bring Your Own Carrier) program. The integration is verified by Genesys and listed on the Genesys AppFoundry.

One-Time Setup:
- Configure Twilio Elastic SIP Trunking with SIP trunk details (Termination URI, Origination SIP URI, credentials)
- Add Twilio as a BYOC carrier in Genesys Cloud with SIP trunk configuration

Connecting Numbers:
- Assign Twilio phone numbers to the BYOC trunk in Genesys Cloud
- Numbers become immediately available for inbound and outbound calling through Genesys

Removing Numbers:
- Unassign phone numbers from the BYOC trunk in Genesys Cloud
- Release numbers from Twilio Console or via API if no longer needed

The integration enables Genesys Cloud WebRTC users to route PSTN calls through Twilio in approximately 100 countries, extending geographic reach beyond Genesys Cloud's native coverage (US, Canada, EU).

More information: https://www.twilio.com/en-us/blog/partners/integrations/twilio-elastic-sip-trunking-delivers-global-pstn-access-genesys-cloud
Configuration guide: https://www.twilio.com/docs/sip-trunking/sample-configuration

---

