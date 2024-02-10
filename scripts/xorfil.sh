#!/bin/bash

# Usage: ./xor_file.sh input_file output_file hex_key

input_file=$1
output_file=$2
hex_key=$3

# Convert the file to hex, XOR each byte with the key, and save back to binary
xxd -p -c 1 "$input_file" | awk "{printf \"%02x\n\", strtonum(\"0x\"\$0)^strtonum(\"0x$hex_key\")}" | xxd -r -p > "$output_file"
