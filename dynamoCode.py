# dynamoCode.py
# Author: Levi Sneller
# Description: DynamoDB helper functions for movie ratings
# Based on code from lab 10
# Claude assisted in debugging errors and modifying code for Flask

import boto3
from boto3.dynamodb.conditions import Key
from decimal import Decimal

# Connect to DynamoDB using EC2DynamoDBRole (no credentials needed)
dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('Movies')

# Function to add movie (and create a movie if it doesn't exist)
def add_rating(title, rating):
    """Add a rating to a movie - creates movie if it doesn't exist yet"""
    try:
        table.update_item(
            Key={"Title": title},
            UpdateExpression="SET Ratings = list_append(if_not_exists(Ratings, :empty), :r)",
            ExpressionAttributeValues={':r': [Decimal(str(rating))], ':empty': []}
        )
        return True
    except Exception as e:
        print(f"[DYNAMO ERROR - add_rating]: {e}")
        return False

# Function to get all ratings
def get_all_ratings():
    """Get all movies and their ratings from DynamoDB"""
    try:
        response = table.scan()
        return response.get("Items", [])
    except Exception as e:
        print(f"[DYNAMO ERROR - get_all_ratings]: {e}")
        return []
