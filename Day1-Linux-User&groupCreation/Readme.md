##  🐧 Interactive User and Group Creation Script

This script allows you to create a Linux group and user interactively.
It checks if the group or user already exists before creating, so it avoids errors and duplicates.

---
## Features

Prompts for a group name and creates it if it doesn’t exist.
Prompts for a username and creates it if it doesn’t exist.
Automatically adds the user to the group.
Creates a home directory for the user.
Sets a default password (Password123) for the user.
Shows clear success/warning messages.

---


## 🔎 Line-by-Line Explanation

1. Shebang
```bash
#!/bin/bash
```
Tells Linux to run the script using Bash shell.

2. Asking for Group Name
```bash
read -p "Enter group name: " groupname
```
Prompts the user to type a group name and stores it in a variable called groupname.

3. Checking & Creating Group
```bash 
if getent group "$groupname" > /dev/null; then
    echo "✅ Group '$groupname' already exists."
else
    sudo groupadd "$groupname"
    echo "✅ Group '$groupname' created."
fi
```

getent group → checks if the group exists.
If not found → groupadd creates the group.
Uses sudo because creating groups requires admin rights.


4 . Asking for Username
```bash
read -p "Enter username: " username
```

Prompts the user to type a username and stores it in a variable called username.


5. Checking & Creating User
```bash
if id "$username" &>/dev/null; then
    echo "⚠️ User '$username' already exists."
else
    sudo useradd -m -s /bin/bash -G "$groupname" "$username"
    echo "$username:Password123" | sudo chpasswd
    echo "✅ User '$username' created and added to group '$groupname'."
fi
```

id username → checks if the user exists.
If not found → useradd creates the user with:
-m → creates home directory (e.g. /home/alice)
-s /bin/bash → sets Bash as the default shell
-G groupname → assigns user to the chosen group
chpasswd → sets default password "Password123".


## 🚀 How to Run

1. Save the script as interactive_user_group.sh.

2. Give it executable permissions:
```bash
chmod +x interactive_user_group.sh
```

3. Run the script:
```bash
./interactive_user_group.sh
```

## 📖 Example Run
$ ./interactive_user_group.sh
Enter group name: devteam
✅ Group 'devteam' created.
Enter username: alice
✅ User 'alice' created and added to group 'devteam'.

## ⚠️ Notes

You must run this script with a user who has sudo privileges.
The default password is set to Password123 (you should change it after login).
If the group or user already exists, the script will not overwrite them.
