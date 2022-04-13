from var.variables import tmp_bucket

def fetch_url():
    response = str("aws s3 cp $your-File s3://" +tmp_bucket+"/$your-Filename" )
    return(response)
