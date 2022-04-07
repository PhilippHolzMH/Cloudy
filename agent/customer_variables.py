def collect_variables(*values):
    with open('terraform.tfvars', 'a') as file:
        file.write("\n".join(values))
    file.close 