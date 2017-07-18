require 'open-uri'

include AwsCookbook::Ec2

module AwsCookbook
  module Sqs

    def list_sqs_queues(region)
      require 'aws-sdk'
      Aws.config.update({
        credentials: Aws::Credentials.new(
          node['aws']['aws_access_key_id'],
          node['aws']['aws_secret_access_key']
        )
      })
      sqs = Aws::SQS::Client.new(region: region)
      sqs_queues = []
      queues = sqs.list_queues
      queues.queue_urls.each do |url|
        sqs_queues.push(
          sqs.get_queue_attributes(
            {
              queue_url: url,
              attribute_names: ['QueueArn']
            }
          ).attributes['QueueArn']
        )
      end
      return sqs_queues
    end
  end
end
