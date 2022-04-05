import shutil
from customer_rds_variables import collect_variables 
def write_tf_use_case (case):
    if case == "1":
        hard_drive_input = input("Which size of hard drive do you need ? 20GB  40GB  80GB ")
        if hard_drive_input == "20" or hard_drive_input == "40" or hard_drive_input == "60": 
            hard_drive_size = hard_drive_input
        else: 
            print("wrong input")
        user_name = input("Which Username should I make to the Administrator ? ")
        collect_variables(user_name,hard_drive_size)
        shutil.copyfile("/Users/pholz/Desktop/neuefische/Cloudy/agent/src/pub_vpc_postgress.tf", "/Users/pholz/Desktop/neuefische/Cloudy/main.tf")
        return(1)
    if case == "2":
        shutil.copyfile("/Users/pholz/Desktop/neuefische/Cloudy/agent/src/pub_vpc_dynamodb.tf", "/Users/pholz/Desktop/neuefische/Cloudy/main.tf")
        return(2)
    else:
        print("wrong input")
    
