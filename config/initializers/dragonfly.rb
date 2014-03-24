#require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "b582e82011925592289973e7f19b3c1c85ce5037e20f221d5452059db57ae451"

  url_format "/media/:job/:name"

  # datastore :file,
  #   root_path: Rails.root.join('public/system/dragonfly', Rails.env),
  #   server_root: Rails.root.join('public')
  #Dragonfly.app.datastore = Dragonfly::DataStorage::S3DataStore.new({
		#datastore.configure do |d|
		datastore :s3,
    	bucket_name: "commeasure-staging-assets",
    	access_key_id: "AKIAIXLPW2M2TOGFPVKQ",
    	secret_access_key: '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',
    	url_host: "commeasure-staging-assets.s3.amazonaws.com"
   #	end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
