current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "connaryscott"
client_key               "#{current_dir}/connaryscott.pem"
validation_client_name   "connaryscott-validator"
validation_key           "#{current_dir}/connaryscott-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/connaryscott"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
