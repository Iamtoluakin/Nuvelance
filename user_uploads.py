import boto3
from botocore.exceptions import NoCredentialsError

LOCAL_FILE = 'user_uploads.py'
BUCKET_NAME = 'nuvalence-bucket2022'
S3_FILE_NAME = 'user_uploads.zip'

def upload_to_s3(local_file, bucket, s3_file):
    ## This function is responsible for uploading the file into the S3 bucket
    try:
        s3.upload_file(local_file, bucket, s3_file)
        print("Upload Successful")
        return True
    except FileNotFoundError:
        print("The file was not found")
        return False
    except NoCredentialsError:
        print("Credentials not available")
        return False


result = upload_to_s3(LOCAL_FILE, BUCKET_NAME, S3_FILE_NAME)
