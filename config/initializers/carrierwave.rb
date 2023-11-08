require 'carrierwave/storage/fog'
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'DO00HA36CVQL3Z32M8XT',                   # required unless using use_iam_profile
    aws_secret_access_key: 'vzokGOKqjitVrR2Ah0QrfOSaiBe4gC1uXX9T8h4/AT8',                        # required unless using use_iam_profile
    use_iam_profile:       false,                         # optional, defaults to false
    region:                'fra1',                  # optional, defaults to 'us-east-1'
    host:                  'todo-backet.fra1.digitaloceanspaces.com',             # optional, defaults to nil
    endpoint:              'http://localhost:3000' # optional, defaults to nil
  }
  config.fog_directory  = 'todo-backet'                                      # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end

