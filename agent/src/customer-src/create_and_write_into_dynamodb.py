import pandas as pd
import boto3 
import time
s3resource=boto3.resource("s3")
s3client=boto3.client("s3")
dynamodb=boto3.resource("dynamodb") 
response = s3client.list_buckets()


def get_column_header(uploaded_file,content):
#    with open(uploaded_file) as csvfile:
#        file = pd.read_csv((csvfile), iterator=True)
#        column_names_full=file.get_chunk(1)
#        column_names=[column for column in column_names_full] 
#        hash_key = column_names[0]
#        range_key = column_names[1]
#        create_dynamotable(uploaded_file,hash_key,range_key)
        write_to_db(uploaded_file,content)

#def create_dynamotable(name,hash_key,range_key):
#    dynamodb.create_table(
#        TableName=name,
#        KeySchema=[
#            {'AttributeName': hash_key,'KeyType': 'HASH'},
#            {'AttributeName': range_key,'KeyType': 'RANGE'}
#            ],
#        AttributeDefinitions=[
#            {'AttributeName': hash_key, 'AttributeType': 'S'},
#            {'AttributeName': range_key, 'AttributeType': 'S'}
#            ],
#        ProvisionedThroughput={'ReadCapacityUnits': 100, 'WriteCapacityUnits': 100})
def write_to_db(db_name,content):
    #time.sleep(5)
    table = dynamodb.Table(db_name)
    table.put_item(Item={content})

for bucket in response['Buckets']:
    bucket = s3resource.Bucket(bucket['Name'])
for obj in bucket.objects.all():
    key=obj.key
    body=obj.get()["Body"].read()
    get_column_header(key,body.decode("utf-8")) 
    
