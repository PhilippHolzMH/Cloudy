def fetch_url(s3name):
    response = str("aws s3 cp $your-File s3://" +s3name +"/$your-Filename" )
    return(response)
