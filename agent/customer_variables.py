def write_into_tfvars(*values):
    with open('terraform.tfvars', 'a') as file:
        file.write("\n".join(values))
        file.write("\n")
    file.close 