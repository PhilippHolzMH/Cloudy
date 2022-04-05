import shutil

def write_tf_use_case (case):
    if case == "1":
        shutil.copyfile("/Users/pholz/Desktop/neuefische/Cloudy/agent/src/pub_vpc_postgress.tf", "/Users/pholz/Desktop/neuefische/Cloudy/main.tf")
        return(1)
    else:
        print("wrong input")
    
