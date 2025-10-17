#!/bin/sh

source "$CONFIG_DIR/plugins/icon_map.sh"

__icon_map "$INFO"

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO" icon="$icon_result"
fi
