#!/bin/bash -e
: "${CDKTN_VERSION:=0.22.0}"
: "${NODE_VERSION:=22.23.2}"
: "${NVM_VERSION:=v0.40.7}"

curl -o- \
  "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
  | bash

chmod +x ~/.nvm/nvm.sh
# shellcheck disable=SC1090
source ~/.nvm/nvm.sh 

nvm install "${NODE_VERSION}"
nvm use node

npm install --global cdktn-cli@"${CDKTN_VERSION}"

# Existing CDKTF projects can keep invoking `cdktf`; the CLI is compatible in v0.22.
cdktn_bin="$(command -v cdktn)"
ln -sfn "${cdktn_bin}" "$(dirname "${cdktn_bin}")/cdktf"
