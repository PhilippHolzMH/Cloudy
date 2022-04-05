import shutil
from customer_variables import collect_variables 

def write_tf_use_case (case):
    if case == "1":
        hard_drive_input = input("Which size of hard drive do you need ? 20GB  40GB  80GB ")
        if hard_drive_input == "20" or hard_drive_input == "40" or hard_drive_input == "60": 
            hard_drive_size = hard_drive_input
        else: 
            print("wrong input")
        user_name = input("Which Username should I make to the Administrator ? ")
        tf_user = "user_name = "+ '"{}"'.format(user_name)
        tf_hdsize = "hd_size = "+ '"{}"'.format(hard_drive_size)
        collect_variables(tf_user,tf_hdsize)
        shutil.copyfile("src/pub_vpc_postgress.tf", "../main.tf")
        return(1)
    if case == "2":
        hash_key = input("which hash-key do you want to use ? ")
        range_key = input ("which range_key do you want to use ? ")
        tf_hash = "hash_key = "+ '"{}"'.format(hash_key)
        tf_range = "range_key = "+ '"{}"'.format(range_key)
        collect_variables(tf_hash,tf_range)
        shutil.copyfile("src/pub_vpc_dynamodb.tf", "../main.tf")
        shutil.move("terraform.tfvars","../terraform.tfvars")
        return(2)
    else:
        print("wrong input")
    
