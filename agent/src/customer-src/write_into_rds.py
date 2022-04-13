import pandas as pd
import boto3 
s3resource=boto3.resource("s3")
s3client=boto3.client("s3")
dynamodb=boto3.resource("dynamodb") 
response = s3client.list_buckets()
dynamotables= [table.name for table in dynamodb.tables.all()]
dynamotable = dynamotables[0]
table = dynamodb.Table(dynamotable)

def get_column_header(uploaded_file):
    with open(uploaded_file) as csvfile:
        file = pd.read_csv((csvfile), iterator=True)
        column_names_full=file.get_chunk(1)
        column_names=[column for column in column_names_full] 
        return(column_names)

def write_to_db(body):
    table.put_item(get_column_header)

for bucket in response['Buckets']:
    bucket = s3resource.Bucket(bucket['Name'])
    print(bucket)
for obj in bucket.objects.all():
    key=obj.key
    body=obj.get()["Body"].read()
    get_column_header(key)
    #write_to_db(body.decode("utf-8"))   
    
#response = rdsclient.describe_db_endpoints()
#for db_instance in response['DBInstances']:
#        db_instance_name = db_instance['DBInstanceIdentifier']
#        db_type = db_instance['DBInstanceClass']
#        db_storage = db_instance['AllocatedStorage']
#        db_engine =  db_instance['Engine']
#        print (db_instance_name,",",db_type,",",db_storage,",",db_engine)
#print(response)
