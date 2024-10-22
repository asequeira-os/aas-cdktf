#!/bin/bash -e
: "${CDKTF_VERSION:=0.20.9}"
: "${NODE_VERSION:=22.10.0}"
: "${NVM_VERSION:=v0.40.1}"

curl -o- \
  "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
  | bash

chmod +x ~/.nvm/nvm.sh
# shellcheck disable=SC1090
source ~/.nvm/nvm.sh 

nvm install "${NODE_VERSION}"
nvm use node

npm install --global cdktf-cli@"${CDKTF_VERSION}"

