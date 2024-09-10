#! /bin/bash

#
# Create a new xata user:
# 1. Run tools/create-user to create a new user + workspace with the Xata API
# 2. Take the workspace id and user's bearer token and update the httpie session config.
# 3. Hit the relevant API endpoints to create a new database, with postgres access enabled.
# 4. Copy the wire connection string to the clipboard.
#
# Usage:
#   ./new-user.sh [user_email] [db_name]
#

# Set defaults for user email, database name, and httpie session file
user_email=${1:-foo@xata.io}
db_name=${2:-pgrolldb}
httpie_session_file=~/.config/httpie/sessions/localhost_6001/xata-local.json

# Create a new user and workspace
output=$(go run ~/git/xata/tools/create_user $user_email)
if [ $? -ne 0 ]; then
  echo "Failed to create user: $output"
  exit 1
fi

# Extract the api key and workspace id from the command output
api_key=$(grep 'API Key:' <<< "$output" | awk '{print $3}')
workspace=$(grep 'Workspace:' <<< "$output" | awk '{print $2}')

# Update the httpie session config with the new user details
jq --arg workspace "$workspace" \
   --arg token "$api_key" \
   '(.headers[] | select(.name == "Host").value) = ($workspace + ".xata.sh") |
    (.headers[] | select(.name == "Authorization").value) = ("Bearer " + $token)' \
   $httpie_session_file \
   | sponge $httpie_session_file

# Enable Postgres access on the workspace
# This is no longer necessary as workspaces now allow Postgres-enabled databases by default
# http -q --session xata-local PATCH http://localhost:6001/workspaces/$workspace/settings postgresEnabled:=true

# Create a new database
http -q --session xata-local PUT http://localhost:6001/workspaces/$workspace/dbs/pgrolldb region=dev postgresEnabled:=true

# Print the user details
echo "User: $user_email"
echo "DB: $db_name"
echo "API Key: $api_key"
echo "Workspace ID: $workspace"
echo "Config file: $httpie_session_file"
echo "Wire connection: 'postgresql://$workspace:$api_key@127.0.0.1:7654/$db_name:main'"

# Copy the wire connection string to the clipboard
echo -n "'postgresql://$workspace:$api_key@127.0.0.1:7654/$db_name:main'" | pbcopy
echo -e "\nWire connection string copied to clipboard."
