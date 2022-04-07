def instance_strength(type):
    if type == "1":
        instance_type = "db.t3.micro"
    if type == "2":
        instance_type = "db.t4g.micro"
    return(instance_type)
