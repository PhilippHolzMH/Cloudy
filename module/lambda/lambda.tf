resource "aws_lambda_function" "create_and_write_into_dynamodb" {
  filename         = "create_and_write_into_dynamodb.zip"
  function_name    = "create_and_write_into_dynamodb"
  role             = "arn:aws:iam::535643436873:role/LabRole"
  handler          = "create_and_write_into_dynamodb.lambda_handler"
  memory_size      = 512
  timeout          = 60
  source_code_hash = filebase64sha256("create_and_write_into_dynamodb.zip")

  runtime = "python3.9"
}

#### DOES NOT WORK WITH SANDBOX ####

#resource "aws_s3_bucket_notification" "bucket_notification" {
#  bucket = AWSS3ID
#  lambda_function {
#    lambda_function_arn = aws_lambda_function.create_and_write_into_dynamodb.arn
#    events              = ["s3:ObjectCreated:Put"]
#    filter_suffix       = ".csv"
#  }
#}
