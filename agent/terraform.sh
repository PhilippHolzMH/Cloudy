#!/bin/bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile #dont ask! just for me
cd .. 
terraform apply -auto-approve