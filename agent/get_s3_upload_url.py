from var.variables import bucket

def fetch_url():
    response = str("http://" +bucket+ ".s3.amazonaws.com/")
    return(response)
