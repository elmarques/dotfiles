#!/bin/bash
IFS=$'\t' read -r MODEL PCT < <(
  jq -r '[.model.display_name // "?", ((.context_window.used_percentage // 0) | round)] | @tsv'
)

PCT=${PCT:-0}
FILLED=$((PCT * 20 / 100))
BAR=$(printf "%${FILLED}s" | tr ' ' '▓')$(printf "%$((20 - FILLED))s" | tr ' ' '░')

echo "$MODEL $BAR ${PCT}%"
