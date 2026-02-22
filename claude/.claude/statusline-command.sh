#!/bin/bash
COMPACT_AT=83

IFS=$'\t' read -r MODEL PCT < <(
  jq -r '[.model.display_name // "?", ((.context_window.used_percentage // 0) | round)] | @tsv'
)

PCT=${PCT:-0}
ADJUSTED=$(( PCT * 100 / COMPACT_AT ))
(( ADJUSTED > 100 )) && ADJUSTED=100

FILLED=$(( ADJUSTED * 20 / 100 ))
BAR=$(printf "%${FILLED}s" | tr ' ' '▓')$(printf "%$((20 - FILLED))s" | tr ' ' '░')

echo "$MODEL $BAR ${ADJUSTED}%"
