from customer_variables import write_into_tfvars


def get_ami(region):
    if region == "1":
        aws_region = "us-west-2"
        aws_ami = "ami-00ee4df451840fa9d"
        tf_region = "region = "+ '"{}"'.format(aws_region)
        tf_ami = "ami = "+ '"{}"'.format(aws_ami)
    if region == "2":
        aws_region = "eu-central-1"
        aws_ami = "ami-0dcc0ebde7b2e00db"
        tf_region = "region = "+ '"{}"'.format(aws_region)
        tf_ami = "ami = "+ '"{}"'.format(aws_ami)
    if region == "3":
        aws_region = "ap-northeast-1"
        aws_ami = "ami-0ab0bbbd329f565e6"
        tf_region = "region = "+ '"{}"'.format(aws_region)
        tf_ami = "ami = "+ '"{}"'.format(aws_ami)
    write_into_tfvars(tf_region,tf_ami)

    return(aws_region)