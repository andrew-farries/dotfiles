#! /bin/sh

# Connect to the RDS instance for the current cell.
# Usage:
#   With the current kubectl context set to the cell namespace:
#     ./cell-rds.sh

# Define the name of the secret in which the connection details are stored
secretName=connection-details

# Take the components of the connection string from the in-cluster secret
echo "Obtaining connection details from secret '$secretName'..."
endpoint=$(kubectl get secret $secretName -o jsonpath='{.data.endpoint}' | base64 --decode)
port=$(kubectl get secret $secretName -o jsonpath='{.data.port}' | base64 --decode)
username=$(kubectl get secret $secretName -o jsonpath='{.data.master_username}' | base64 --decode)
password=$(kubectl get secret $secretName -o jsonpath='{.data.attribute\.master_password}' | base64 --decode)

# echo "Endpoint: $endpoint"
# echo "Port: $port"
# echo "Username: $username"
# echo "Password: $password"

# Connect to the RDS instance
echo "Connecting to RDS instance..."
pgcli "postgresql://$username:$password@$endpoint:$port"
