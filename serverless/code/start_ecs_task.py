import os
import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.run_task(
        cluster='pantori-cluster',
        launchType='FARGATE',
        taskDefinition=os.environ["TASK_DEFINITION"],
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': ["subnet-0daa0686751c2e25c"],
                'securityGroups':["sg-0972630476c31fb70", "sg-03acae366a5565f7a"],
                'assignPublicIp': 'DISABLED'
            }
        },
        count=1
    )
    return {'statusCode': 200, 'body': 'ECS task started'}
