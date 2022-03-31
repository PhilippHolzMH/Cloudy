echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
aws s3 rb s3://upload-bucket-48916516 --force 
terraform destroy -auto-approve