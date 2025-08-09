#!/usr/bin/env bash

if [ -z "$1" ]; then exit; fi

path_to_submodule=$1

# Delete the relevant line from the .gitmodules file:
git config -f .gitmodules --remove-section submodule.$path_to_submodule

# Delete the relevant section from .git/config
git config -f .git/config --remove-section submodule.$path_to_submodule

# Unstage and remove $path_to_submodule only from the index (to prevent losing information)
git rm --cached $path_to_submodule

# Track changes made to .gitmodules
git add .gitmodules

# Commit the superproject
git commit -m "Remove submodule `basename path_to_submodule`"

# Delete the now untracked submodule files
rm -rf $path_to_submodule
rm -rf .git/modules/$path_to_submodule