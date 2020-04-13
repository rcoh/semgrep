#!/bin/bash
set -e

echo "Installing via homebrew"
brew tap returntocorp/sgrep https://github.com/returntocorp/sgrep.git
brew install semgrep

echo "Running homebrew recipe checks"
brew test semgrep
echo "from env, $VERSION"

echo "$VERSION" > version

brew info semgrep --json | jq -r '.[0].installed[0].version' | tee brew-version

semgrep --version > semgrep-version
echo -n "Validating brew the version ($(cat brew-version) vs. $(cat release-version))..."
diff brew-version version
echo "OK!"

echo -n "Validating brew the version ($(cat semgrep-version) vs. $(cat release-version))..."
diff semgrep-version version
echo "OK!"
