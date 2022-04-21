import os
import time
from convert_variables.get_s3_upload_url import fetch_url
from output.outputrds import output_rds
from output.outputdyn import output_dyn
from output.outputapp import output_app
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
    output_app(uploadurl)