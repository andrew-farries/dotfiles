#!/bin/bash

#
# Remove all databases from my Xata workspace, in either the dev, staging or
# prod environments.
#

# Initialize variables
env="$1"
httpie_session=""
wsID=""
apiDomain=""

# Use case statement to validate the environment
case "$env" in
    dev)
        httpie_session=$HTTPIE_DEV_SESSION
        wsID="lehvg4"
        apiDomain="api.dev-xata.dev"
        ;;
    staging)
        httpie_session=$HTTPIE_STAGING_SESSION
        wsID="ev65oc"
        apiDomain="api.staging-xata.dev"
        ;;
    prod)
        httpie_session=$HTTPIE_PROD_SESSION
        wsID="ici71u"
        apiDomain="api.xata.io"
        ;;
    *)
        echo "Error: Invalid environment."
        echo "Usage: $0 {dev|staging|prod}"
        ;;
esac

# Get all databases in the workspace
databases=($(http --session-read-only=$httpie_session GET "https://$apiDomain/workspaces/$wsID/dbs" | \
  jq -r '.databases[].name'))

# Delete each database
for db in "${databases[@]}"; do
    echo "Deleting database: $db";
    http --session-read-only=$httpie_session -b DELETE "https://$apiDomain/workspaces/$wsID/dbs/$db";
done
