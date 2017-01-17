#!/bin/bash

# Exit immediately if something exits with error(s).
set -e

# Install global deps.

# Snap-CI specific stuff.
BASH_FILE="/var/go/.bashrc"
if [ -e "$BASH_FILE" ]; then
    if [ ! -w "$BASH_FILE" ]; then
        sudo chmod u+w "$BASH_FILE"
        echo "$BASH_FILE is now writable!"
        source "$BASH_FILE"
    fi
fi
# End Snap-CI specific stuff.

sudo curl -o- -L https://yarnpkg.com/install.sh | bash
npm install hexo-cli@1.0.2 webpack@1.14.0 --global
yarn install

# Generate Hexo static site.
hexo clean
hexo generate
webpack

# BAM! Deploy.
hexo deploy

# Run the server!
hexo server -s
