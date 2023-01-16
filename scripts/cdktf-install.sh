#!/bin/bash -e
: ${CDKTF_VERSION:=0.14.3}
: ${NODE_VERSION:=18.13}
: ${NVM_VERSION:=v0.39.1}

curl -o- \
  "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
  | bash

source ~/.nvm/nvm.sh 
chmod +x ~/.nvm/nvm.sh

nvm install ${NODE_VERSION}
nvm use node

npm install --global cdktf-cli@${CDKTF_VERSION}

