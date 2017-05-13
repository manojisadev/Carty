import boto3
import json
from watson_developer_cloud import NaturalLanguageUnderstandingV1
import watson_developer_cloud.natural_language_understanding.features.v1 as \
    features

natural_language_understanding = NaturalLanguageUnderstandingV1(
    version='2017-02-27',
    username='----',
    password='')  
sqs = boto3.client('sqs')
response = sqs.list_queues()
print(response['QueueUrls'])

sqs1 = boto3.resource('sqs')

queue = sqs1.get_queue_by_name(QueueName='MyGroovyQueue')

for message in queue.receive_messages(MessageAttributeNames=['All']):
	if message.message_attributes is not None:
		text = message.message_attributes.get('Text').get('StringValue')
		text = text.encode('ascii','ignore').decode('ascii')
		ID = message.message_attributes.get('ID').get('StringValue')
		text_text = '{0}'.format(text)
		id_text = '{0}'.format(text)
		response = natural_language_understanding.analyze(
		text = text_text,
		features = [features.Sentiment()])
		client = boto3.client('sns')
		jsonData = json.dumps([text,ID])
		print jsonData
		responses = client.publish(
		TopicArn='arn:aws:sns:us-west-2:844384473955:Reviews',
		Message='Reviews',
		MessageStructure='String',	
		MessageAttributes={
		'text': {
		'DataType': 'String',
		'StringValue': text,
		},
		'ID': {
		'DataType': 'String',
		'StringValue': ID,
		},
		'sentiments': {
		'DataType': 'String',
		'StringValue': response['sentiment']['document']['label'],
		}	
		}		
		)
		print response['sentiment']['document']['label']
