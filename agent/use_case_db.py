import shutil
from customer_variables import collect_variables 
from instance import instance_strength
from db_engine import engine
def write_dbtf_use_case (case):
    if case == "1":
        engine_input = input ("Which DB-Engine you would like to use ? Postgress (1) MariaDB (2)")
        if engine_input == "1" or engine_input == "2":
            engine(engine_input)
        hard_drive_input = input("Which size of hard drive do you need ? Choose between 20-60GB ")
        if hard_drive_input >= "20" and hard_drive_input <= "60": 
            instance_type = instance_strength(hard_drive_input)
            user_name = input("Which Username should I make to the Administrator ? ")
            db_name = input ("Define your DB-Name: ")
            tf_user = "user_name = "+ '"{}"'.format(user_name)
            tf_hdsize = "hd_size = "+ '"{}"'.format(hard_drive_input)
            tf_dbname = "identifier = "+ '"{}"'.format(db_name)
            tf_instance_type = "instance_type = "+ '"{}"'.format(instance_type)
            collect_variables(tf_user,tf_hdsize,tf_instance_type, tf_dbname)
            shutil.copyfile("src/pub_vpc_postgress.tf", "../main.tf")
            shutil.move("terraform.tfvars","../terraform.tfvars")            
        else:
            print("wrong input")
    if case == "2":
        table_name = input ("Define your Tablename: ")
        hash_key = input("which hash-key do you want to use ? ")
        range_key = input ("which range_key do you want to use ? ")
        tf_table_name = "table_name = "+ '"{}"'.format(table_name)
        tf_hash = "hash_key = "+ '"{}"'.format(hash_key)
        tf_range = "range_key = "+ '"{}"'.format(range_key)
        collect_variables(tf_hash,tf_range,tf_table_name)
        shutil.copyfile("src/pub_vpc_dynamodb.tf", "../main.tf")
        shutil.move("terraform.tfvars","../terraform.tfvars")
        

   
