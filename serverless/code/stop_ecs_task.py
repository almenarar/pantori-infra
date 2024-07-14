import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.list_tasks(
        cluster='pantori-cluster',
        desiredStatus='RUNNING'
    )
    for task in response['taskArns']:
        response = client.describe_tasks(
            cluster='pantori-cluster',
            tasks = [task]
        )
        if response['tasks'][0]['group'] == 'family:pantori-notifier':
            client.stop_task(
                cluster='pantori-cluster',
                task=task,
                reason='Routine complete'
            )
            return {'statusCode': 200, 'body': 'ECS task stopped'}
    return {'statusCode': 400, 'body': 'ECS task not found'}