import os
import time
from get_s3_upload_url import fetch_url

def convert_to_tf():
    time.sleep(2)
    os.system("sh terraform.sh")
    os.system("rm ../main.tf")
    os.system("rm ../terraform.tfvars")
    uploadurl = fetch_url()
    print("//////////////////////////////////////////////////////////////////////////////////")
    print("/// Please upload your file to: " + uploadurl+"///")
    print("//////////////////////////////////////////////////////////////////////////////////")