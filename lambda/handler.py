"""
Minimal Lambda handler – processes SQS messages and writes to DynamoDB.

Replace the business logic inside `process_record` with your own implementation.
"""
import json
import os
import time
import uuid

import boto3

dynamodb = boto3.resource("dynamodb")
TABLE_NAME = os.environ["DYNAMODB_TABLE"]


def handler(event, context):
    table = dynamodb.Table(TABLE_NAME)

    for record in event.get("Records", []):
        process_record(table, record)

    return {"statusCode": 200, "body": "OK"}


def process_record(table, record):
    body = json.loads(record["body"])
    table.put_item(
        Item={
            "pk": body.get("pk", str(uuid.uuid4())),
            "sk": body.get("sk", str(int(time.time()))),
            "payload": body,
        }
    )
