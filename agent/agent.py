import os
import time
from get_s3_upload_url import fetch_url
from use_case import write_tf_use_case 


use_case_input = input("Please type your usecase: SQL-DB (1) Dynamic-DB (2) ")
write_tf_use_case(use_case_input)

if use_case_input == "1":
    time.sleep(5)
    os.system("sh terraform.sh")
    os.system("rm /Users/pholz/Desktop/neuefische/Cloudy/main.tf")
    uploadurl = fetch_url()
    print("//////////////////////////////////////////////////")
    print("/// Please upload your file to: " + uploadurl+"///")
    print("//////////////////////////////////////////////////")

if use_case_input == "2":
    time.sleep(5)
    os.system("sh terraform.sh")
    os.system("rm /Users/pholz/Desktop/neuefische/Cloudy/main.tf")
    uploadurl = fetch_url()
    print("//////////////////////////////////////////////////")
    print("/// Please upload your file to: " + uploadurl+"///")
    print("//////////////////////////////////////////////////")