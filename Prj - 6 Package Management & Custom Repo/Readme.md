## 📘 README — Understanding APT and YUM in Linux

## Why this project ?:
While managing software in Linux, we often need to install, update, or remove packages (applications, libraries, or dependencies).
Different Linux distributions use different package managers to handle these tasks efficiently.
That’s where APT and YUM come into play.

## 🎯 Why We Created This

This document was created to clarify the purpose and difference between APT and YUM, two of the most widely used package management tools in Linux systems.
It helps new system administrators and DevOps learners understand:
Why both tools exist, Which one to use on their system, andHow they work behind the scenes.


## ⚙️ What Are APT and YUM
🔹 APT (Advanced Package Tool)
Used in Debian-based systems like Ubuntu, Debian, and Kali.
Works with .deb packages.
Helps you install, update, and remove software easily.

Example Commands:
```bash
sudo apt update        # Refresh package lists
sudo apt upgrade       # Upgrade all packages
sudo apt install nginx # Install Nginx web server
sudo apt remove nginx  # Remove Nginx
```

🔹 YUM (Yellowdog Updater, Modified)
Used in RHEL-based systems like CentOS, RHEL, and Amazon Linux 2.
Works with .rpm packages.
Handles dependencies automatically during install or removal.

Example Commands:
```bash
sudo yum update        # Update all system packages
sudo yum install httpd # Install Apache web server
sudo yum remove httpd  # Remove Apache
sudo yum clean all     # Clean up cache files
```

## 🧰 How We Created / Set It Up

To understand and use APT or YUM:

Identify your Linux distribution:  cat /etc/os-release\
If you see Ubuntu/Debian, use apt. \
If you see RHEL/CentOS/Amazon, use yum (or dnf).\
Run the package manager commands to install, update, or remove packages.\
For troubleshooting, check your repository list:
```bash
APT: /etc/apt/sources.list and /etc/apt/sources.list.d/
YUM: /etc/yum.repos.d/
```
## Script with Explanation
```bash
#!/bin/bash

PACKAGES=("vim" "git" "wget")
for pkg in "${PACKAGES[@]}"; do 
    echo -n "🔍 Checking $pkg... " 
    if command -v $pkg &>/dev/null; then 
        echo "Already installed ✅" 
    else 
        echo "Not installed ❌ — Installing..."
        sudo apt install -y $pkg 
    fi
done

echo "🎉 All required packages are now installed."
```

🧠 Line-by-line Explanation\

🧱 1. PACKAGES=("vim" "git" "wget")\
This creates a Bash array named PACKAGES.\
It contains the list of package names you want to check or install.\
You can add more names as needed, e.g. ("curl" "htop" etc).


🔁 2. for pkg in "${PACKAGES[@]}"; do\
This starts a for loop.\
${PACKAGES[@]} expands to all elements in the array.\
So the loop runs once for each package name (vim, then git, then wget).

Example iteration:\
1st run → pkg="vim"\
2nd run → pkg="git"\
3rd run → pkg="wget"

💬 3. echo -n "🔍 Checking $pkg... "

echo prints text to the terminal.\
-n prevents a new line — so the next message appears on the same line.\
output = 🔍 Checking vim...

🧰 4. if command -v $pkg &>/dev/null; then

The command -v <program> command checks if that program exists on your system (in PATH).\
If the program exists, it returns its path (e.g., /usr/bin/vim).\
If not, it returns nothing and exits with a non-zero status.\
&>/dev/null means redirect both stdout and stderr (output and errors) to /dev/null, effectively silencing the output.\
So this line silently checks:\
“Does this command exist on the system?”

✅ 5. echo "Already installed ✅"\
If the command exists, this line executes.

❌ 6. else\
Runs when the package is not installed (i.e., previous check failed).

📦 7. echo "Not installed ❌ — Installing..."\
Informs the user that installation is starting.


⚙️ 8. sudo apt install -y $pkg\
Installs the package using APT.\
sudo → runs with root privileges (required for installations).\
apt install → installs a package.\
-y → automatically answers “yes” to prompts (so no manual confirmation needed).\
$pkg → the package name from the loop (like vim, git, etc.).


## Here’s a simple and clear table showing the basic difference between APT and YUM 👇

| Feature                 | **APT**                                           | **YUM**                                                              |
| ----------------------- | ------------------------------------------------- | -------------------------------------------------------------------- |
| **Full Form**           | Advanced Package Tool                             | Yellowdog Updater, Modified                                          |
| **Used In**             | Debian-based systems (Ubuntu, Debian, Kali, Mint) | RHEL-based systems (CentOS, Red Hat, Amazon Linux)                   |
| **Package Type**        | `.deb` packages                                   | `.rpm` packages                                                      |
| **Repository Files**    | `/etc/apt/sources.list`                           | `/etc/yum.repos.d/`                                                  |
| **Update Command**      | `sudo apt update`                                 | `sudo yum update`                                                    |
| **Install Command**     | `sudo apt install <package>`                      | `sudo yum install <package>`                                         |
| **Remove Command**      | `sudo apt remove <package>`                       | `sudo yum remove <package>`                                          |
| **Dependency Handling** | Automatically resolves dependencies efficiently   | Also handles dependencies but older YUM was slower (DNF improved it) |
| **Cache Location**      | `/var/lib/apt/lists/`                             | `/var/cache/yum/`                                                    |
| **Successor Tool**      | APT is still used actively                        | Replaced by **DNF** in newer systems (RHEL 8+, Fedora)               |

Note - For any queries you can reach out to me at saiyedalisha110@gmail.com

## AUTHOR
Name - Saiyed Alisha
Designation - sysAdmin | AWS










