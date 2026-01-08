#!/bin/bash

### Install nvm, nodejs 18.10, and configure for the project

set -e

echo "Installing nvm (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load nvm - check both possible installation locations
if [ -d "/usr/local/share/nvm" ]; then
    export NVM_DIR="/usr/local/share/nvm"
else
    export NVM_DIR="$HOME/.nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "Installing Node.js 18.10..."
nvm install 18.10

echo "Setting Node.js 18.10 as default..."
nvm alias default 18.10

echo "Using Node.js 18.10 for this project..."
nvm use 18.10

# Create .nvmrc file to specify Node version for this project
echo "18.10" > .nvmrc

echo "Installation complete!"
echo "Node version: $(node --version)"
echo "npm version: $(npm --version)"
echo ""
echo "Note: You may need to restart your terminal or run 'source ~/.bashrc' (or ~/.zshrc)"
echo "In the future, just run 'nvm use' in this directory to use the correct Node version."

# Install Vue CLI 5.0.8 globally if not installed
echo ""
echo "Checking for Vue CLI..."
if npm list -g @vue/cli 2>/dev/null | grep -q @vue/cli; then
    CURRENT_VERSION=$(npm list -g @vue/cli --depth=0 2>/dev/null | grep @vue/cli | awk -F@ '{print $NF}')
    echo "Vue CLI is already installed (version $CURRENT_VERSION)"
    if [ "$CURRENT_VERSION" != "5.0.8" ]; then
        echo "Installing Vue CLI 5.0.8..."
        npm install -g @vue/cli@5.0.8
    fi
else
    echo "Installing Vue CLI 5.0.8..."
    npm install -g @vue/cli@5.0.8
fi

echo ""
echo "Vue CLI version: $(vue --version)"
echo "Setup complete!"