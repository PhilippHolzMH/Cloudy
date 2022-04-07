from use_case_db import write_dbtf_use_case 
from start_tf import convert_to_tf
from region import region_to_ami
region_input = input ("Hi There ! Where do you want you cloud7 ? US (1) EU (2) AS (3)")
region_to_ami(region_input)
use_case_input = input("Please type your usecase: Database (1) website (2) non-public VPC (3) ")
if use_case_input == "1":
    db_use_case_input = input ("Which Type of Database you want to use ? With Instance (1) Without Instance (2) ")
    write_dbtf_use_case(db_use_case_input)
    convert_to_tf()
#if use_case_input == "2":
#    write_wstf_use_case(use_case_input)
#if use_case_input == "3":
#    write_nonpbvps_use_case(use_case_input)


