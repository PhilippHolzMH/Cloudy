def get_instance_strength(type):
    if type <= "40":
        instance_type = "db.t3.micro"
    if type >= "41":
        instance_type = "db.t4g.micro"
    return(instance_type)
