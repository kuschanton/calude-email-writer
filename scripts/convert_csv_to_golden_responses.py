#!/usr/bin/env python3
"""
Convert RFP CSV to golden responses markdown files organized by category
"""

import csv
import os
import re
from collections import defaultdict

# Read CSV
csv_path = "./rfp/golden_responses/CRC_Telco_RFP_Requirements.xlsx - Requirements (1).csv"
output_dir = "./rfp/golden_responses"

# Parse CSV and group by category
questions_by_category = defaultdict(list)

with open(csv_path, 'r', encoding='utf-8') as f:
    # Skip first 2 empty rows
    next(f)
    next(f)
    reader = csv.DictReader(f)
    for row in reader:
        # Skip empty rows
        if not row.get('ID') or not row.get('Category'):
            continue

        category = row.get('Category', '').strip()
        if not category:
            continue

        questions_by_category[category].append({
            'id': row.get('ID', '').strip(),
            'question': row.get('Question', '').strip(),
            'importance': row.get('Importance', '').strip(),
            'answer': row.get('Answers', '').strip(),
            'proof': row.get('Proof if needed', '').strip()
        })

# Create markdown files for each category
for category, questions in questions_by_category.items():
    # Create safe filename from category
    filename = re.sub(r'[^a-z0-9]+', '_', category.lower()).strip('_')
    filepath = os.path.join(output_dir, f"{filename}.md")

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(f"# {category}\n\n")
        f.write(f"Golden responses for {category}-related RFX questions.\n\n")
        f.write(f"---\n\n")

        for q in questions:
            f.write(f"## Q{q['id']}: {q['question'][:100]}{'...' if len(q['question']) > 100 else ''}\n\n")
            f.write(f"**Full Question**: {q['question']}\n\n")
            f.write(f"**Importance**: {q['importance']}\n\n")
            f.write(f"**Answer**:\n\n{q['answer']}\n\n")

            if q['proof']:
                f.write(f"**Proof/Reference**: {q['proof']}\n\n")

            f.write(f"---\n\n")

    print(f"Created: {filepath}")

# Create index file
index_path = os.path.join(output_dir, "README.md")
with open(index_path, 'w', encoding='utf-8') as f:
    f.write("# Golden Responses\n\n")
    f.write("Curated high-quality responses to common RFX questions, organized by category.\n\n")
    f.write("## Categories\n\n")

    for category in sorted(questions_by_category.keys()):
        filename = re.sub(r'[^a-z0-9]+', '_', category.lower()).strip('_')
        count = len(questions_by_category[category])
        f.write(f"- [{category}]({filename}.md) ({count} questions)\n")

print(f"\nCreated index: {index_path}")
print(f"\nTotal categories: {len(questions_by_category)}")
print(f"Total questions: {sum(len(q) for q in questions_by_category.values())}")
