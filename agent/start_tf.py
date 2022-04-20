import os
import time
from get_s3_upload_url import fetch_url
from outputrds import output_rds
from outputdyn import output_dyn
def initrds_tf(s3name,db_name,db_region):
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url(s3name)
    output_rds(uploadurl,db_name,db_region)
def initdyn_tf(s3name):
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url(s3name)
    output_dyn(uploadurl)

def initapp_tf(s3name):
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url(s3name)
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////")
    print("///                                                                                                                                         ///")
    print("/// Please upload your CSV-File to the S3-Bucket using following command: " + uploadurl+" ///")
    print("///                                                                                                                                         ///")
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////")
