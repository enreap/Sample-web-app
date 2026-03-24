#!/bin/bash

# -----------------------
# Parameters
# -----------------------
REMOTE_USER=$1
REMOTE_HOST=$2
SSH_KEY_PATH=${3:-"$HOME/.ssh/id_ed25519.pub"}  # default to ~/.ssh/id_rsa if not provided

if [ -z "$REMOTE_USER" ] || [ -z "$REMOTE_HOST" ]; then
    echo "Usage: $0 <REMOTE_USER> <REMOTE_HOST> [SSH_KEY_PATH]"
    exit 1
fi

echo "Copying Jenkins SSH key to $REMOTE_USER@$REMOTE_HOST..."

ssh-copy-id -i "${SSH_KEY_PATH}.pub" ${REMOTE_USER}@${REMOTE_HOST}

echo "SSH key copied successfully!"
