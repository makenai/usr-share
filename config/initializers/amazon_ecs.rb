require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:associate_tag]     = APP_CONFIG[:aws_tag]
  options[:AWS_access_key_id] = APP_CONFIG[:aws_key]
  options[:AWS_secret_key]    = APP_CONFIG[:aws_secret]
end