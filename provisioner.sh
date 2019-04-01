#!/bin/bash

TERRAFORM="https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip"

# base tasks
sudo yum update -y
sudo yum install unzip zip -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install azure-cli -y

# hashicorpo cli tools
function hashicorp {
    TOOL_NAME=$1
    ZIP_URL=$2
    mkdir /tmp/$TOOL_NAME
    cd /tmp/$TOOL_NAME
    echo "$ZIP_URL :: downloading ..."
    curl -sS $ZIP_URL > $TOOL_NAME.zip
    unzip $TOOL_NAME.zip
    sudo cp $TOOL_NAME /usr/local/bin/$TOOL_NAME
    rm -rf /tmp/$TOOL_NAME
    echo "$TOOL_NAME :: is installed successfully"
}  

hashicorp "terraform" "$TERRAFORM"