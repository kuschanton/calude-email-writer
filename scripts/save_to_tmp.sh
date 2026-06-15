#!/bin/bash
# Save RFP answer to tmp file
# Usage: ./scripts/save_rfp_answer.sh "answer content"

if [ -z "$1" ]; then
    echo "Error: No content provided"
    exit 1
fi

echo "$1" > /tmp/rfp_answer.txt
echo "✅ Saved to /tmp/rfp_answer.txt"
