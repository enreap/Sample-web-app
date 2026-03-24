#!/bin/bash

REMOTE_USER=$1
REMOTE_HOST=$2
SSH_KEY_PATH=${3:-"$HOME/.ssh/id_ed25519"}

echo "Copying Jenkins SSH key to $REMOTE_USER@$REMOTE_HOST..."

# Check key exists
if [ ! -f "${SSH_KEY_PATH}.pub" ]; then
    echo "ERROR: SSH key not found!"
    exit 1
fi

# Copy key (disable host verification for first-time connection)
ssh-copy-id -o StrictHostKeyChecking=no -i "${SSH_KEY_PATH}.pub" ${REMOTE_USER}@${REMOTE_HOST}

# Check result
if [ $? -ne 0 ]; then
    echo "ERROR: ssh-copy-id failed"
    exit 1
fi

echo "SSH key copied successfully!"
