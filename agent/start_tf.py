import os
import time
from get_s3_upload_url import fetch_url

def inits3_tf():
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url()
    print("/////////////////////////////////////////////////////////////////////////////////////////")
    print("/// Please use this command in your terminal: " + uploadurl+"///")
    print("/////////////////////////////////////////////////////////////////////////////////////////")

def init_tf():
    time.sleep(1)
    os.system("sh terraform.sh")