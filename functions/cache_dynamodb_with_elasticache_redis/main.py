from __future__ import print_function
import os
import time
import boto3
import redis
import random
import string

ELASTI_CACHE_ENDPOINT = os.environ["ElastiCacheEndpoint"]
DYNAMO_DB_TABLE_NAME = os.environ["DynamoDBTableName"]
WORD = "".join([random.choice(string.ascii_letters + string.digits) for n in xrange(16)])
TIME = str(time.time()).split(".")[0]


def handle(event, context):
    client = boto3.client("dynamodb")
    r = redis.StrictRedis(
            host=ELASTI_CACHE_ENDPOINT,
            port=6379,
            db=0
            )

    client.put_item(
            TableName=DYNAMO_DB_TABLE_NAME,
            Item={
                "Word": {"S": WORD},
                "CreatedAt": {"N": TIME}
                }
            )

    resp = client.scan(
            TableName=DYNAMO_DB_TABLE_NAME,
            ConsistentRead=True
            )
    last_range_key = sorted([x["CreatedAt"]["N"] for x in resp["Items"]])[0]
    last_hash_key = [x for x in resp["Items"] if last_range_key == x["CreatedAt"]["N"]][0]["Word"]["S"]

    if (int(TIME) - int(last_range_key)) > 30:
        client.delete_item(
                TableName=DYNAMO_DB_TABLE_NAME,
                Key={
                    "Word": {"S": last_hash_key},
                    "CreatedAt": {"N": last_range_key}
                    }
                )

        if r.exists(last_hash_key):
            r.delete(last_hash_key)
            print("Deleted from cache: {}, {}".format(last_hash_key, last_range_key))
        else:
            print("{} does not exist".format(last_hash_key))

    for item in resp["Items"]:
        hash_key = item["Word"]["S"]
        range_key = item["CreatedAt"]["N"]
        redis_keys = r.scan_iter()
        if hash_key in redis_keys:
            print("Cache hit: {}, {}".format(hash_key, r.get(hash_key)))
        else:
            print("Cache miss: {}, {}".format(hash_key, range_key))
            r.set(hash_key, range_key)
            print("Added to cache: {}, {}".format(hash_key, range_key))
