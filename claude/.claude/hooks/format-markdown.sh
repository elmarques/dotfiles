#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
[[ "$FILE" == *.md ]] && prettier --write "$(realpath "$FILE")" >/dev/null 2>&1
exit 0
