import boto3 
import csv
import time

def get_column_header(uploaded_file,dynamodb,filepath):
    with open(filepath+uploaded_file) as csvfile:
        reader = csv.DictReader(csvfile)
        fieldnames = reader.fieldnames
        hash_key = fieldnames[0]
        range_key = fieldnames[1]
        create_dynamotable(uploaded_file,hash_key,range_key,dynamodb)
        get_content_for_put_item(uploaded_file,dynamodb,filepath)


def create_dynamotable(name,hash_key,range_key,dynamodb):
    dynamodb.create_table(
        TableName=name,
        KeySchema=[
            {'AttributeName': hash_key,'KeyType': 'HASH'},
            {'AttributeName': range_key,'KeyType': 'RANGE'}
            ],
        AttributeDefinitions=[
            {'AttributeName': hash_key, 'AttributeType': 'S'},
            {'AttributeName': range_key, 'AttributeType': 'S'}
            ],
        ProvisionedThroughput={'ReadCapacityUnits': 100, 'WriteCapacityUnits': 100})
        
def get_content_for_put_item (uploaded_file,dynamodb,filepath):
    time.sleep(5)
    with open(filepath+uploaded_file, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        fieldnames = reader.fieldnames
    with open(filepath+uploaded_file, newline='') as csvfile:
        row_file = csv.reader(csvfile)
        next(row_file)
        for row in row_file:
            item_save={}
            for item in range(0,len(fieldnames)):
                item_save[fieldnames[item]]= row[item]
            write_to_db(uploaded_file,item_save,dynamodb)

def write_to_db(db_name,content,dynamodb):
    table = dynamodb.Table(db_name)
    table.put_item(Item=content)

def get_bucket(response,s3resource,dynamodb,s3client,filepath):
    for bucket in response['Buckets']:
        bucket = s3resource.Bucket(bucket['Name'])
        bucket_name = bucket.name
    for obj in bucket.objects.all():
        key=obj.key
    s3client.download_file(bucket_name,key,filepath + key)
    time.sleep(5)
    get_column_header(key,dynamodb,filepath)

def lambda_handler(event,context):
    s3resource=boto3.resource("s3")
    s3client=boto3.client("s3")
    dynamodb=boto3.resource("dynamodb") 
    response=s3client.list_buckets()
    filepath ='/tmp/'
    get_bucket(response,s3resource,dynamodb,s3client,filepath)
