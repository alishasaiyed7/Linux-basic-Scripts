#!/bin/bash

PACKAGES=("vim" "git" "wget") //as per your requirement you can add
for pkg in "${PACKAGES[@]}"; do #this is a for loop so it will check for all 3 one by 1 and then it will exit 
    echo -n "🔍 Checking $pkg... " 
    if command -v $pkg &>/dev/null; then # here we are checking if -v vim (version of vim) gives any output then
        echo "Already installed ✅" # that its already installed
    else #if not
        echo "Not installed ❌ — Installing..."
        sudo apt install -y $pkg #it will install the pacakge
    fi
done

echo "🎉 All required packages are now installed." 