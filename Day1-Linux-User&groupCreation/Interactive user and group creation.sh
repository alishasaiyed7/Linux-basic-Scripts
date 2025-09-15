#!/bin/bash

# scipt to create a user and group interactively

# Ask for group name

# Check if group exists
if getent group "$groupname" > /dev/null; then
    echo "✅ Group '$groupname' already exists."
else
    sudo groupadd "$groupname"
    echo "✅ Group '$groupname' created."
fi

# Ask for username
read -p "Enter username: " username

# Check if user exists
if id "$username" &>/dev/null; then
    echo "⚠️ User '$username' already exists."
else
    sudo useradd -m -s /bin/bash -G "$groupname" "$username"
    echo "$username:Password123" | sudo chpasswd
    echo "✅ User '$username' created and added to group '$groupname'."
fi

