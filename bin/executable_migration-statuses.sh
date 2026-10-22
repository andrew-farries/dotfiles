#! /bin/bash

#
# Fetch the migration status of every cell in a cluster.
# Usage:
#   ./migration-statuses.sh [<path-to-cell-migrations-directory>]
# The cluster for which the migration statuses are fetched is determined by the
# current kube context.
#

# Take the path to the migrations directory from the first argument, or default
# to a path that assumes the script is run from the root of the xata repository
migPath=${1:-xb/xbcell/dbstore/dbmigrations}

# Get all cell namespaces in the cluster
clu_namespaces=($(kubectl get ns | grep '^clu-' | awk '{print $1}'))

# Iterate over each cell and fetch the migration status
for ns in "${clu_namespaces[@]}"; do
  echo -n "Cell ID: $ns - Migration status: "
  kubectl config set-context --current --namespace $ns &> /dev/null

  # Fetch the connection details secret JSON
  secretName=connection-details
  secretJson=$(kubectl get secret $secretName -o json)

  # Extract the required fields
  endpoint=$(echo "$secretJson" | jq -r '.data.endpoint' | base64 --decode)
  port=$(echo "$secretJson" | jq -r '.data.port' | base64 --decode)
  username=$(echo "$secretJson" | jq -r '.data.master_username' | base64 --decode)
  password=$(echo "$secretJson" | jq -r '.data["attribute.master_password"]' | base64 --decode)

  # Fetch the migration version
  version=$(migrate \
    --database "pgx://$username:$password@$endpoint:$port/xata?search_path=xata_private" \
    --path $migPath \
    version 2>&1)

  # Display migration status
  echo -n $version

  # Goto a previous migration version
  # if [[ $version == "93" ]]; then
  #   migrate \
  #   --database "pgx://$username:$password@$endpoint:$port/xata?search_path=xata_private" \
  #   --path $migPath \
  #   goto 92
  # fi

  echo ""
done
