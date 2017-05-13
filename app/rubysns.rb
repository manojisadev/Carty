require 'thread'
require 'twitter'
require 'mysql2' 
require 'aws-sdk'
require 'json'

# AWS_ACCESS_KEY_ID = ''
# AWS_SECRET_ACCESS_KEY = ''
# ENDPOINT = ''
# AMAZON_SQS_TEST_QUEUE = ""
# SQS_TEST_MESSAGE = ''

# sqs = Aws::SQS::Client.new(
#   access_key_id: '',
#   secret_access_key: '',
#   region: 'us-west-2'
# )

queue_url = sqs.get_queue_url(queue_name: 'SecondQueue').queue_url

for i in 0..10 
  receive_message_result = sqs.receive_message({
    queue_url: queue_url, 
    message_attribute_names: ["All"], # Receive all custom attributes.
    max_number_of_messages: 10, # Receive at most one message.
    wait_time_seconds: 0 # Do not wait to check for the message.
  })

  #client = Mysql2::Client.new(:host => "aaw1x6grbqjhsh.cckmbe3onbme.us-east-1.rds.amazonaws.com", :username => "root", :password => "root1234", :database => "twtassig2")
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "Carty")
  receive_message_result.messages.each do |message|
  	thing = message.body
    parsed = JSON.parse(thing)
    #parsed["MessageAttributes"].each do |m|
      #puts m[0]+' '+m[1]["Value"]
    #end 
    sentiment = parsed["MessageAttributes"]["sentiments"]["Value"]
    text = parsed["MessageAttributes"]["text"]["Value"]
    id = parsed["MessageAttributes"]["ID"]["Value"]
    puts sentiment+' '+text+' '+id
    client.query("UPDATE reviews SET sentiment = ('#{client.escape(sentiment)}') WHERE id = #{client.escape(id)}")
    sqs.delete_message({
      queue_url: queue_url,
      receipt_handle: message.receipt_handle    
    })

  end
end