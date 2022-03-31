from var.variables import tmp_bucket

def fetch_url():
    response = str("http://" +tmp_bucket+ ".s3.amazonaws.com/")
    return(response)
