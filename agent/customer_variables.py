def collect_variables(value1,value2):
    with open('terraform.tfvars', 'w') as file:
        file.write(value1 + "\n" + value2)
    file.close 