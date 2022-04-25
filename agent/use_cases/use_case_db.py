import shutil
from customer_variables import write_into_tfvars 
from convert_variables.instance import get_instance_strength
from convert_variables.db_engine import get_db_engine
from start_tf import initrds_tf
from start_tf import initdyn_tf
import os
def write_dbtf_use_case (case,s3name,db_region):
    if case == "1":
        engine_input = input ("Which DB-Engine you would like to use ? Postgress (1) MariaDB (2)")
        if engine_input == "1" or engine_input == "2":
            get_db_engine(engine_input)
        hard_drive_input = input("Which size of hard drive do you need ? Choose between 20-60GB ")
        if hard_drive_input >= "20" and hard_drive_input <= "60": 
            instance_type = get_instance_strength(hard_drive_input)
            user_name = input("Which Username should I make to the Administrator ? ")
            db_name = input ("Define your DB-Name: ")
            tf_user = "user_name = "+ '"{}"'.format(user_name)
            tf_hdsize = "hd_size = "+ '"{}"'.format(hard_drive_input)
            tf_dbname = str.lower("identifier = "+ '"{}"'.format(db_name))
            tf_instance_type = "instance_type = "+ '"{}"'.format(instance_type)
            write_into_tfvars(tf_user,tf_hdsize,tf_instance_type, tf_dbname)
            shutil.copyfile("src/pub_vpc_postgress.tf", "../main.tf")
            shutil.move("terraform.tfvars","../terraform.tfvars") 
            initrds_tf(s3name,db_name,db_region)
           
        
    if case == "2":
        os.system("sh ziplambda.sh")
        shutil.copyfile("src/pub_vpc_dynamodb.tf", "../main.tf")
        shutil.move("terraform.tfvars","../terraform.tfvars")
        initdyn_tf(s3name)

   
