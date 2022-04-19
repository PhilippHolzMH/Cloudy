import shutil

def write_privvpctf_use_case():
    shutil.copyfile("src/priv_vpc.tf", "../main.tf")
    shutil.move("terraform.tfvars","../terraform.tfvars")    