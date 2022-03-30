#!/bin/bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
cd .. 
terraform apply -auto-approve