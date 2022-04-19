from customer_variables import write_into_tfvars
def bucket_name_for_output(name):
    tmp_bucket = name
    tf_s3 = "s3name = "+ '"aws s3api create-bucket --bucket {} --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2"'.format(tmp_bucket)
    write_into_tfvars(tf_s3)
    return(tmp_bucket)