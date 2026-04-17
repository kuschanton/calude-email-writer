#!/bin/bash
# Copy file contents to clipboard reliably
# Usage: ./scripts/copy_to_clipboard.sh <file_path>

if [ -z "$1" ]; then
    echo "Error: Please provide a file path"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    exit 1
fi

# Use input redirection - most reliable method
pbcopy < "$1"

echo "✅ Copied to clipboard: $1"
