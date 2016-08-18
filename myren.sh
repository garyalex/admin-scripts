#!/bin/bash

input="$1"

output=${input::-16}

echo "$input --> $output.mp3"
mv "$input" "$output.mp3"
