#!/bin/bash

# Usage: ./xor_file.sh input_file output_file

input_file="image.tar"
output_file="out.tar"
hex_key="0b"

# Convert the file to hex, XOR each byte with the key, and save back to binary
xxd -p -c 1 "$input_file" | awk "{printf \\"%02x\\\\n\\", strtonum(\\"0x\\"$0)^strtonum(\\"0x$hex_key\\")}" | xxd -r -p > "$output_file"
