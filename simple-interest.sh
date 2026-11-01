#!/usr/bin/env bash
set -euo pipefail

read -r -p "Enter principal amount: " principal
read -r -p "Enter annual rate of interest (%): " rate
read -r -p "Enter time period (years): " time

# Validate numeric input (non-negative values).
for value in "$principal" "$rate" "$time"; do
  if ! [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "Error: Please enter valid non-negative numeric values." >&2
    exit 1
  fi
done

# Use awk for decimal arithmetic.
interest=$(awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN { printf "%.2f", (p*r*t)/100 }')
total=$(awk -v p="$principal" -v i="$interest" 'BEGIN { printf "%.2f", p+i }')

echo
echo "Simple Interest: $interest"
echo "Total Amount:    $total"
