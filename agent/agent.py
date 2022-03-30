import os
import time
from get_s3_upload_url import fetch_url
from use_case import write_tf_use_case 


use_case_input = input("Please type your usecase: website (1) ")
write_tf_use_case(use_case_input)

time.sleep(5)
os.system("sh /Users/pholz/Desktop/neuefische/Cloudy/agent/terraform.sh")
time.sleep(60)
os.system("rm /Users/pholz/Desktop/neuefische/Cloudy/main.tf")
if use_case_input == "1":
    uploadurl = fetch_url()
    print("Please upload your file to: " + uploadurl)