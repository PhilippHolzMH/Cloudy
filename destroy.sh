#!/bin/bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile #dont ask! just for me
aws s3 rb s3://customer-upload-bucket12 --force 
terraform destroy -auto-approve