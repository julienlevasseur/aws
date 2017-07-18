require 'open-uri'

include AwsCookbook::Ec2

module AwsCookbook
  module Rds

    def list_rds_instances(region)
      require 'aws-sdk'
      Aws.config.update({
        credentials: Aws::Credentials.new(
          node['aws']['aws_access_key_id'],
          node['aws']['aws_secret_access_key']
        )
      })
      rds = Aws::RDS::Resource.new(region: region)
      db_instances = []
      rds.db_instances.each do |i|
        db_instances.push(i.id)
      end
      return db_instances
    end

    def get_rds_max_connections
      return {
        't2.micro':   66,
        't2.small':   150,
        'm3.medium':  296,
        't2.medium':  312,
        'M3.large':   609,
        't2.large':   648,
        'M4.large':   648,
        'M3.xlarge':  1237,
        'R3.large':   1258,
        'M4.xlarge':  1320,
        'M2.xlarge':  1412,
        'M3.2xlarge': 2492,
        'R3.xlarge':  2540
      }
  end
end
