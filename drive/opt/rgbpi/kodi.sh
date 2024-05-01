#!/bin/bash

# Timings to add
timings=(
    "320 1 20 32 45 240 1 2 3 16 0 0 0 60.000000 0 6514560 1"
    "720 1 29 69 117 480 1 3 6 34 0 0 0 30 1 14670150 1"
    "720 1 29 69 117 576 1 7 6 38 0 0 0 25 1 14656125 1"
)

file="/opt/rgbpi/ui/data/timings.dat"

# Check if the timings already exist in the file
for line in "${timings[@]}"; do
    if ! grep -qF "$line" "$file"; then
        echo "$line" >> "$file"
    fi
done

# Execute Kodi
kodi
