# Quality

Golden responses for Quality-related RFX questions.

---

## Q17: Do you provide a real-time dashboard showing MOS (Mean Opinion Score), Jitter, and Packet Loss?

**Full Question**: Do you provide a real-time dashboard showing MOS (Mean Opinion Score), Jitter, and Packet Loss?

**Importance**: Critical

**Answer**:

Yes. Twilio Voice Insights provides comprehensive call quality monitoring through real-time dashboards and REST APIs, displaying MOS (Mean Opinion Score), jitter, and packet loss among other critical metrics.

Voice Insights captures time-series views of call quality metrics collected every second for Voice SDK calls and every 10 seconds for SIP/carrier calls. Metrics include MOS scores (1-5 scale, where >4.2 is good and <3.5 is poor), jitter (variation in packet arrival times), packet loss percentage, round-trip time, and audio levels. The dashboard includes threshold indicators based on ITU-T VoIP quality standards to flag when call degradation occurs.

For real-time alerts, the Voice SDK emits warning events when metrics cross defined thresholds, which can be surfaced in your application UI or trigger automated responses. Call quality data is also accessible programmatically via REST API for custom dashboards or reporting pipelines.

More information: https://www.twilio.com/docs/voice/voice-insights
Advanced features: https://www.twilio.com/docs/voice/voice-insights/advanced-features

---

## Q18: Can we access a "per-call" signaling trace (PCAP) directly from your portal for troubleshooting?

**Full Question**: Can we access a "per-call" signaling trace (PCAP) directly from your portal for troubleshooting?

**Importance**: Medium

**Answer**:

Yes. Twilio provides per-call SIP packet captures (PCAPs) for Elastic SIP Trunking and SIP Domain calls, downloadable directly from the Console Call Logs.

PCAPs are retained for 14 days and can be analyzed with standard tools like Wireshark or tcpdump for troubleshooting call setup failures, authentication issues, and routing problems.

Note: When TLS or TCP is enabled, SIP signaling packets will not be visible in PCAP captures.

More information: https://help.twilio.com/articles/360025293074-View-Twilio-SIP-Call-Packet-Captures-PCAPs-

---

## Q19: What is your Site Ready Service (SRS) process ?

**Full Question**: What is your Site Ready Service (SRS) process ?

**Importance**: Medium

**Answer**:

Twilio is a cloud-based communications platform with no physical equipment to install at customer sites, so traditional Site Ready Service (hardware installation preparation) does not apply.

However, Twilio offers Professional Services to ensure technical readiness and successful deployment. Professional Services provides expert guidance on implementation planning, software architecture review, integration with existing systems (including Genesys Cloud), compliance preparation, and customized solutions tailored to your business needs. The team works hand-in-hand with customers to shorten time-to-deploy, optimize platform use, and provide ongoing support throughout the project lifecycle.

More information: https://www.twilio.com/en-us/professional-services

---

