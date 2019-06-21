import boto3
import datetime
import json

BUCKET_NAME = "suaaa7-json-data"
FILE_NAME = "test_{0:%Y%m%d-%H%M}.json"

def lambda_handler(event, context):
    s3 = boto3.resource("s3")

    bucket = s3.Bucket(BUCKET_NAME)

    pred_result = {
        "modelname": "base_model", 
        "accracy": 0.90
    }

    json_str = json.dumps(pred_result)

    now = datetime.datetime.now()
    ret = bucket.put_object(
        ACL="private",
        Body=json_str,
        Key=FILE_NAME.format(now),
        ContentType="text/json"
    )

    return str(ret)
