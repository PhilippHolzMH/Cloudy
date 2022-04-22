from use_cases.use_case_db import write_dbtf_use_case 
from use_cases.use_case_nonpbvpc import write_privvpctf_use_case
from use_cases.use_case_app import use_case_app
from start_tf import initapp_tf
from convert_variables.region import get_ami
from convert_variables.name_s3 import bucket_name_for_output

region_input = input ("Hi There ! Where do you want to locate your cloud7 ? US (1) EU (2) AS (3) ")
s3_name = input("How do you want to name your s3-Bucket: ")
db_region = get_ami(region_input)
tmp_bucket = bucket_name_for_output(s3_name)


use_case_input = input("Please type your usecase: Database (1) Hosted-Data (2) non-public VPC (3) ")
if use_case_input == "1":
    db_use_case_input = input ("Which Type of Database you want to use ? With Instance (1) Without Instance (2) ")
    db_name = write_dbtf_use_case(db_use_case_input,s3_name,db_region)
if use_case_input == "2":
    use_case_app()
    initapp_tf(s3_name)
if use_case_input == "3":
    write_privvpctf_use_case()
    
