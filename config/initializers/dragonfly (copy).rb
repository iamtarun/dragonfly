require 'dragonfly'

# Configure
Dragonfly.app(:images).configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "b582e82011925592289973e7f19b3c1c85ce5037e20f221d5452059db57ae451"

  url_format "/media/:job/:name"

  #developmat environment
  if Rails.env.development?
	  datastore :file,
	    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
	    server_root: Rails.root.join('public')
	end

	#production environment
	if Rails.env.production?
		datastore = Dragonfly::DataStorage::S3DataStore.new
		datastore.configure do |d|
    	d.bucket_name = ENV["FOG_DIRECTORY"]
    	d.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    	d.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
   	end
	end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
#Rails.application.middleware.use Dragonfly::Middleware
Rails.application.middleware.use Dragonfly::Middleware, :images
# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
