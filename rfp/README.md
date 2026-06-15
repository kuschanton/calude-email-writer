# RFP and Security Questionnaire Workspace

This directory contains all RFP and security questionnaire work.

## Directory Structure

```
rfp/
├── README.md                          # This file
├── security_docs/                     # Shared security resources
│   └── (SOC2 reports, compliance certs, security whitepapers)
├── golden_responses/                  # Pre-approved answers from past RFPs
│   └── (Best answers, templates, golden RFPs)
└── [customer_name]/                   # Individual customer RFPs
    ├── original_rfp.[csv|txt]         # RFP file with answers written back
    ├── context.md                      # Supporting materials, notes
    ├── history.md                      # Finalized Q&A pairs only
    └── attachments/                    # Additional files
```

## Usage

Invoke the RFP skill: `/rfp`

The skill will guide you through:
1. Setting up customer directory
2. Working through questions one-by-one
3. Drafting answers with public documentation links
4. Saving answers back to original RFP file

## Resources

- **security_docs/**: Add SOC2 reports, compliance certifications, security whitepapers here
- **golden_responses/**: Add pre-approved answers and best RFP responses here for reuse
