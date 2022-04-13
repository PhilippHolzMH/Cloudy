from use_case_db import write_dbtf_use_case 
from use_case_nonpbvpc import write_privvpctf_use_case
from start_tf import inits3_tf
from start_tf import init_tf
from region import get_ami

region_input = input ("Hi There ! Where do you want to locate your cloud7 ? US (1) EU (2) AS (3) ")
get_ami(region_input)

use_case_input = input("Please type your usecase: Database (1) website (2) non-public VPC (3) ")
if use_case_input == "1":
    db_use_case_input = input ("Which Type of Database you want to use ? With Instance (1) Without Instance (2) ")
    write_dbtf_use_case(db_use_case_input)
    inits3_tf()
###### dev-status ######
#if use_case_input == "2":
#    write_wstf_use_case(use_case_input)
if use_case_input == "3":
    write_privvpctf_use_case()
    init_tf()
