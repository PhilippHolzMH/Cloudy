from use_case_db import write_dbtf_use_case 
from use_case_nonpbvpc import write_privvpctf_use_case
from start_tf import initrds_tf
from start_tf import initdyn_tf
from region import get_ami
from name_s3 import bucket_name_for_output


region_input = input ("Hi There ! Where do you want to locate your cloud7 ? US (1) EU (2) AS (3) ")
s3_name = input("How do you want to name your s3-Bucket: ")
db_region = get_ami(region_input)
tmp_bucket = bucket_name_for_output(s3_name)


use_case_input = input("Please type your usecase: Database (1) website (2) non-public VPC (3) ")
if use_case_input == "1":
    db_use_case_input = input ("Which Type of Database you want to use ? With Instance (1) Without Instance (2) ")
    db_name = write_dbtf_use_case(db_use_case_input)
    initrds_tf(s3_name,db_name,db_region)
###### dev-status ######
#if use_case_input == "2":
#    write_wstf_use_case(use_case_input)
if use_case_input == "3":
    write_privvpctf_use_case()
    initdyn_tf(s3_name)
