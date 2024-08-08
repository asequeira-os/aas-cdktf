#!/bin/bash -e
./go-install
./terraform-install
./cdktf-install.sh
./gcloud-cli-install
./sql-proxy-install
./aliases
./verify_all
