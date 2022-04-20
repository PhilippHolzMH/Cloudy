import shutil
from customer_variables import write_into_tfvars

def use_case_ws():
    desired_instances = input("How many Instances do you desire (max 6) ? ")
    if desired_instances <= "6":
        max_instances = input("How many Instances do you want at peak-time (max 6) ? ")
        if max_instances <="6" and max_instances >= desired_instances:
           low_instances = input("How many Instances do you want at least? ")
           if low_instances <= desired_instances:
              tf_desired = "desired_capacity = {}".format(desired_instances)
              tf_max = "max_size = {}".format(max_instances)
              tf_low = "min_size = {}".format(low_instances)
           else: print("Your input has to be lower than " +desired_instances)
        else: print("Your input has to be below or equal to 6 and higher or equal" +desired_instances) 
    write_into_tfvars(tf_desired,tf_max,tf_low)
    shutil.copyfile("src/pub_vpc_app.tf", "../main.tf")
    shutil.move("terraform.tfvars","../terraform.tfvars")   
