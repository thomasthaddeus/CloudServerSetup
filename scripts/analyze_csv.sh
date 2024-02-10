#!/bin/bash

# Path to the CSV file
csv_file="/path/to/your/file.csv"

# Output JSON file
output_json="/path/to/your/output.json"

# Ensure the CSV file path is provided
if [ -z "$csv_file" ]; then
    echo "CSV file path not provided."
    exit 1
fi

# Check if the CSV file exists
if [ ! -f "$csv_file" ]; then
    echo "CSV file does not exist."
    exit 1
fi

# Initializing JSON file
echo "{" > "$output_json"

# File Size
file_size=$(ls -lh "$csv_file" | awk '{print $5}')
echo ""file_size": "$file_size"," >> "$output_json"

# Number of Lines
num_lines=$(wc -l < "$csv_file")
echo ""number_of_lines": $num_lines," >> "$output_json"

# Number of Columns
num_columns=$(head -1 "$csv_file" | sed 's/[^,]//g' | wc -c)
echo ""number_of_columns": $num_columns," >> "$output_json"

# Column Names
column_names=$(head -1 "$csv_file")
echo ""column_names": "$column_names"" >> "$output_json"

# Closing JSON
echo "}" >> "$output_json"
