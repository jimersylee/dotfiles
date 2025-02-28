#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title genpsw
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description generate password
# @raycast.author Jimmy Lee

#!/bin/bash

# Set the password length
LENGTH=12

# Generate the password
PASSWORD=$(openssl rand -base64 $LENGTH)

# Print the password
echo "$PASSWORD"
