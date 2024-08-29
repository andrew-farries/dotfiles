#! /bin/bash

#
# Print the connection strings for all cells in a cluster. Intended to be
# used in conjunction with `xargs` to perform operations on each cell.
#
# The cluster for which the connection strings are fetched is determined by the
# current kube context.
#
# Usage:
#   ./cell-connstrs.sh
#

# Get all cell namespaces in the cluster
clu_namespaces=($(kubectl get ns | grep '^clu-' | awk '{print $1}'))

# Iterate over each cell and print the connection string
for ns in "${clu_namespaces[@]}"; do
  kubectl config set-context --current --namespace $ns &> /dev/null

  # Fetch the connection details secret JSON
  secretName=connection-details
  secretJson=$(kubectl get secret $secretName -o json)

  # Extract the required fields
  endpoint=$(echo "$secretJson" | jq -r '.data.endpoint' | base64 --decode)
  port=$(echo "$secretJson" | jq -r '.data.port' | base64 --decode)
  username=$(echo "$secretJson" | jq -r '.data.master_username' | base64 --decode)
  password=$(echo "$secretJson" | jq -r '.data["attribute.master_password"]' | base64 --decode)

  # Print the connection string
  echo "postgres://$username:$password@$endpoint:$port/xata"
done
