# Branded caller id

Golden responses for Branded caller id-related RFX questions.

---

## Q22: Do you provide branded caller id in all our countries? What are the country not covered?

**Full Question**: Do you provide branded caller id in all our countries? What are the country not covered?

**Importance**: High

**Answer**:

Refer to Country Coverage tab

---

## Q23: Is it a free feature or it is an additional package? if it has a cost, can you explain in which coun...

**Full Question**: Is it a free feature or it is an additional package? if it has a cost, can you explain in which country and what is the cost model?

**Importance**: Medium

**Answer**:

Branded Calling is a paid feature, not included in standard voice services. It is priced on a per-call basis for outbound calls made from Twilio phone numbers.

Twilio offers two tiers: Basic Branded Calling (displays business name only) and Enhanced Branded Calling (displays business name, logo, and call reason). The pricing model is straightforward: a per-call charge applies when an outbound branded call is made to a mobile device on supported networks.

More information: https://www.twilio.com/docs/voice/branded-calling

---

## Q24: What are the limitations of this feature?

**Full Question**: What are the limitations of this feature?

**Importance**: Medium

**Answer**:

Branded Calling has several key limitations:

Device and carrier support: While Basic Branded Calling (business name) displays on most smartphones, Enhanced Branded Calling features (logo and call reason) render only on select mobile devices with Android 14+ or iOS 18.5+. Actual display depends on the terminating carrier and device capabilities.

Character limits: Display names are limited by carrier (15-32 characters depending on network). Call reason is limited to 64 characters maximum.

Prerequisites required: Branded Calling requires an approved Business Profile and Voice Integrity bundle (Basic) or Business Profile and STIR/SHAKEN bundle (Enhanced). Display names must match the legal business name or DBA in the Customer Profile.

Bundle management: Display names, logos, and call reasons cannot be updated once approved. Changes require creating a new bundle and reassigning phone numbers, which may cause temporary loss of branding during the transition.

Compliance: Branded Calling is not HIPAA-eligible, as it processes business information for display name verification.

More information: https://help.twilio.com/articles/22312096414363

---

