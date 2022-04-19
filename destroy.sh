#!/bin/bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile #dont ask! just for me
terraform destroy -auto-approve
rm terraform.tfvars
rm main.tf
rm create_and_write_into_dynamodb.zip