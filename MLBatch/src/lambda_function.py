import boto3
import json

BUCKET_NAME = "ss-json-data"
FILE_NAME = "test.json"

def lambda_handler(event, context):
    s3 = boto3.resource("s3")

    bucket = s3.Bucket(BUCKET_NAME)

    pred_result = {
        "modelname": "base_model", 
        "accracy": 0.90
    }

    json_str = json.dump(pred_result)

    ret = bucket.put_object(
        ACL="private",
        Body=json_str,
        Key=FILE_NAME,
        ContentType="text/json"
    )

    return str(ret)
