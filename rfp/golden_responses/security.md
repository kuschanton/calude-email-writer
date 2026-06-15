# Security

Golden responses for Security-related RFX questions.

---

## Q49: Do you provide security measures to protect our Agent to receive SPAM calls?

**Full Question**: Do you provide security measures to protect our Agent to receive SPAM calls?

**Importance**: Medium

**Answer**:

Twilio Programmable Voice provides capabilities to implement security features and controls that protect agents from receiving SPAM or unwanted calls. These features require implementation by the customer.

Call Screening and Filtering:
- Programmable Voice workflows can be implemented to filter calls based on caller ID, reputation, or custom rules before connecting to agents
- Blocklists can be maintained for known SPAM numbers, automatically rejecting or redirecting these calls
- Integration with third-party SPAM detection services for enhanced call filtering

Authentication and Verification:
- Voice CAPTCHA solutions can be implemented to verify legitimate callers and deter automated SPAM calls
- Custom IVR logic requiring caller input or authentication before reaching agents
- IVR flows built using Twilio Studio or APIs to validate caller identity

Analytics and Detection:
- Real-time analytics and fraud detection tools can be implemented to identify suspicious call patterns
- Voice Insights monitors call quality and patterns for anomaly detection
- Automated alerts can be configured for unusual call volumes or patterns

Twilio Programmable Voice provides the building blocks for implementing multiple layers of SPAM protection, ensuring agents receive only legitimate calls while minimizing SPAM risk.

---

## Q50: Do you provide security measures to block caller-id/phone number spoofing to avoid our clients to be...

**Full Question**: Do you provide security measures to block caller-id/phone number spoofing to avoid our clients to be scammed?

**Importance**: Medium

**Answer**:

Twilio provides security features and industry-standard protocols to prevent spoofing of your phone numbers:

Outbound Call Protection (calls originated through Twilio):
- Verified Caller ID: Twilio verifies outbound caller IDs to ensure only authorized numbers are used when making calls through the platform
- Number Pool Management: Tight control over which numbers can be used for outbound calls, preventing unauthorized usage
- SHAKEN/STIR Compliance: Twilio supports SHAKEN/STIR protocols in applicable regions, cryptographically signing calls to prove authenticity and caller identity

Industry-Standard Protection:
- SHAKEN/STIR adoption across carriers enables receiving networks to verify call authenticity and identify spoofed calls
- Carriers can block or flag calls that fail SHAKEN/STIR verification, reducing spoofing success rates

Important Limitation:
- Twilio can only protect calls originating from or passing through the Twilio platform
- Spoofing that occurs entirely outside Twilio's network (scammers spoofing your numbers on other carriers without using Twilio) is beyond Twilio's direct control
- SHAKEN/STIR industry standards provide the best defense against external spoofing, as carriers can detect and block unauthenticated calls

For calls made through Twilio, these measures ensure your phone numbers are protected and verifiable, reducing the risk of scammers impersonating your business.

---

