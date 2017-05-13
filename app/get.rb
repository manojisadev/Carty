require 'mysql2' 
require 'thread'
require 'twitter' 
require 'aws-sdk'

# AWS_ACCESS_KEY_ID = ''
# AWS_SECRET_ACCESS_KEY = ''
# ENDPOINT = 'http://queue..com'
# AMAZON_SQS_TEST_QUEUE = "SQS-Test-Queue-Ruby"
# SQS_TEST_MESSAGE = 'This is a test message.'



# sqs = Aws::SQS::Client.new(
#   access_key_id: '',
#   secret_access_key: '',
#   region: 'us-west-2'
# )
# queue_url = sqs.get_queue_url(queue_name: 'MyGroovyQueue').queue_url

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "Carty")
result = client.query("SELECT * FROM reviews where sentiment is NULL");
result.each do |row|
	puts row["comment"]
	sqs.send_message({queue_url: queue_url, message_body: 'Reviews',
		message_attributes: {
			"Text" => {
				string_value: row["comment"],
				data_type: "String"
			},
			"ID" => {
				string_value: row["id"].to_s,
				data_type: "String"
			}
		}
		})
end