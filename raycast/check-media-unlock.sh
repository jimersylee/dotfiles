#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title check-media-unlock
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName check

# Documentation:
# @raycast.description check-media-unlock
# @raycast.author Jimmy Lee

bash <(curl -L -s check.unlock.media) -M 4

