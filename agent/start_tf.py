import os
import time
from get_s3_upload_url import fetch_url

def initrds_tf(s3name,db_name,db_region):
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url(s3name)
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////")
    print("///                                                                                                             ///")
    print("/// Please use this command in your terminal: " + uploadurl+"          ///")
    print("///                                                                                                             ///")
    print("/// Your SQL-DB is callable at following Endpoint: "+ db_name +".cpbioztdqjbb."+db_region+ ".rds.amazonaws.com              ///")
    print("///                                                                                                             ///")
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////")

def initdyn_tf(s3name):
    time.sleep(1)
    os.system("sh terraform.sh")
    uploadurl = fetch_url(s3name)
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////")
    print("///                                                                                                                                         ///")
    print("/// Please upload your CSV-File to the S3-Bucket using following command: " + uploadurl+" ///")
    print("///                                                                                                                                         ///")
    print("///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////")

