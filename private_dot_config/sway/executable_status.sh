#! /bin/sh

# Sway status bar

# Define icons (requires a NerdFont)
clockIcon="\uf64f"
dockerIcon="\uf308"

# Define the various sections
date=$(date +'%d %b %k:%M')
kubeContext=$(kubectl config current-context)

echo -e "$dockerIcon $kubeContext    $clockIcon $date"
