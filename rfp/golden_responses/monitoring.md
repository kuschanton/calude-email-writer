# Monitoring

Golden responses for Monitoring-related RFX questions.

---

## Q32: Do you offer Automated Synthetic Testing (heartbeating) to verify Toll-Free and DID reachability 24/...

**Full Question**: Do you offer Automated Synthetic Testing (heartbeating) to verify Toll-Free and DID reachability 24/7?

**Importance**: High

**Answer**:

Twilio does not offer a built-in automated synthetic testing or heartbeat monitoring service for individual phone number reachability.

However, customers can implement synthetic testing using Twilio's APIs to build custom monitoring solutions:
- Use the Voice API to programmatically place test calls to your DIDs and toll-free numbers
- Monitor call completion status, SIP response codes, and connection quality via Voice Insights
- Set up automated test schedules using external monitoring tools or cron jobs
- Configure alerts based on call failure rates or connection issues

Twilio's Super Network continuously monitors 4,800+ carrier connections in real-time and automatically reroutes traffic away from degraded paths, ensuring high availability and call quality without requiring customer intervention.

Twilio provides infrastructure-level monitoring and transparency through the Twilio Status Page (status.twilio.com), which tracks real-time health of voice services, carrier connectivity, and platform components.

For enterprise deployments requiring automated reachability testing, Twilio Professional Services can assist in designing custom monitoring solutions tailored to your requirements.

---

## Q33: Do you have proactive monitoring outside of the previous question? Could you explain which ones?

**Full Question**: Do you have proactive monitoring outside of the previous question? Could you explain which ones?

**Importance**: High

**Answer**:

Yes. Twilio provides multiple layers of proactive monitoring:

Infrastructure-Level Monitoring:
- Real-time carrier and network health monitoring across 4,800+ carrier connections
- Automatic anomaly detection analyzing billions of data signals daily for delivery rate drops, carrier routing changes, and network latency issues
- Automatic traffic rerouting within microseconds when degraded paths are detected
- 24/7 Network Operations Center (NOC) with real-time visibility into the entire delivery chain

Call Quality Monitoring:
- Voice Insights continuously tracks MOS scores, jitter, packet loss, and call completion rates
- Automatic quality warnings triggered when metrics breach ITU-T thresholds
- Trust & Engagement Insights monitors call deliverability and answer rate trends

Application-Level Monitoring:
- Debugger automatically logs errors, warnings, and exceptions across voice, messaging, and API calls
- Alarms send proactive email or webhook notifications when error thresholds are exceeded (configurable by error code, count, and time period)
- Alert triggers fire within 15 seconds of threshold breach
- Call and message logs with detailed SIP error codes and failure analysis

Status Transparency:
- Twilio Status Page (status.twilio.com) provides real-time updates on platform health, incidents, and maintenance windows
- API access to status data for integration with customer monitoring systems

These systems work together to detect and resolve issues before they impact end users, with visibility provided through Console dashboards, REST APIs, and real-time alerts.

---

## Q34: Can your system trigger automated alerts based on quality threshold drops? if yes, explain how?

**Full Question**: Can your system trigger automated alerts based on quality threshold drops? if yes, explain how?

**Importance**: Medium

**Answer**:

Yes. Twilio provides automated alerting based on quality thresholds through multiple mechanisms:

Voice Insights Quality Alerts:
- Automatically detects when call quality metrics breach ITU-T thresholds (MOS < 3.5, jitter > 30ms, packet loss > 1%)
- Flags calls with quality issues in Console Call Logs (highlighted in red)
- Provides quality warning events in real-time during active calls

Debugger Alarms:
- Monitor for specific error codes, error types, or all errors/warnings
- Configure thresholds by error count within time windows (5 min, 15 min, 1 hour, 12 hours, 24 hours)
- Trigger email notifications or webhook POST requests within 15 seconds of threshold breach
- Webhook payloads include account ID, error count, timestamp, error code, and diagnostic details for programmatic handling

Monitor Alerts API:
- Programmatically configure alert triggers for specific error conditions
- Set up custom rules based on SIP error codes, call failures, or quality degradation
- Route notifications to email, webhook endpoints, or third-party monitoring systems

Trust & Engagement Insights (Voice):
- Alerts on sudden drops in answer rates or increases in call blocking/labeling
- Monitors spam flagging trends and carrier filtering

Configuration is done via Console or REST API, enabling integration with external incident management systems (PagerDuty, ServiceNow, etc.) for escalation workflows.

---

## Q35: Do you provide monitoring/metrics for each call leg? if yes, explain how?

**Full Question**: Do you provide monitoring/metrics for each call leg? if yes, explain how?

**Importance**: High

**Answer**:

Yes. Voice Insights provides detailed monitoring and metrics for each call leg separately, enabling granular troubleshooting of specific network segments.

For Elastic SIP Trunking calls:
- SIP Edge: Metrics for Twilio's media gateway communicating with your SIP infrastructure (inbound and outbound streams)
- Carrier Edge: Metrics for traffic between Twilio and the destination carrier

Metrics tracked per leg:
- Codec type (typically PCMU/G.711)
- Packet Loss: Percentage with detection thresholds
- Jitter: Average and maximum values in milliseconds
- Round-Trip Time (RTT): Latency measurements
- MOS Score: Quality rating per leg (1-5 scale)
- Audio Levels: Input/output volume
- Packet Rate: Packets sent/received per second

Access methods:
- Console Call Logs: Per-call summary showing metrics for each edge
- Voice Insights API: Programmatic access to call metrics filtered by edge
- Time-Series Views: Metrics collected every 10 seconds for carrier/SIP calls with graphs showing quality trends throughout call duration

By comparing metrics across different legs, you can pinpoint exactly where quality degradation occurs (within your infrastructure, Twilio's network, or the carrier path), enabling faster root cause identification.

---

## Q36: What audit log capabilities do you offer?

**Full Question**: What audit log capabilities do you offer?

**Importance**: Medium

**Answer**:

Twilio provides comprehensive audit logging through Monitor Events, tracking all actions taken via API, Console, or by Twilio
  personnel.

  Event Coverage:
  - Over 60 resource types including account changes, user activity, phone number operations, SIP trunking configuration,
  voice/messaging resources, and security events
  - Full list of event types available in documentation

  Event Attributes:
  - Event type, resource affected, actor information, source IP address, timestamp, before/after state

  Retention:
  - Enterprise/Administration/Security Edition: 13 months
  - Free tier: 30 days

  Access Methods:
  - REST API
  - Console UI
  - SIEM integration and export capabilities

  More information: https://www.twilio.com/docs/usage/monitor-events

---

