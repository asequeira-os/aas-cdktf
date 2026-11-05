#!/bin/bash -e
./go-install
./terraform-install
./cdktn-install.sh
./gcloud-cli-install
./sql-proxy-install
./aliases
./verify_all
