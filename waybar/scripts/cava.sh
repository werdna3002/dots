#!/usr/bin/env bash

# Single awk process for the whole stream: if waybar goes away, awk dies on
# SIGPIPE, which in turn kills cava, so nothing is left running orphaned.
cava -p "$HOME/.config/cava/waybar" | awk -F';' '
BEGIN {
    # Array instead of substr(): some awks count bytes, not characters,
    # which would split these multi-byte glyphs into invalid UTF-8
    n = split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", glyphs, " ")
    chars[0] = " "
    for (j = 1; j <= n; j++) chars[j] = glyphs[j]
}
{
    out = ""
    count = 0

    for (i = 1; i <= NF && count < 20; i++) {
        if ($i ~ /^[0-9]+$/) {
            v = $i + 0

            # Log-like scaling for more visible low-level movement
            level = 0
            if (v > 0) {
                level = int(log(v + 1) / log(1001) * 8)
            }

            if (level < 0) level = 0
            if (level > 8) level = 8

            out = out chars[level]
            count++
        }
    }

    # JSON output for Waybar
    gsub(/\\/, "\\\\", out)
    gsub(/"/, "\\\"", out)
    printf "{\"text\":\"%s\",\"tooltip\":\"CAVA visualizer\"}\n", out
    fflush()
}'
