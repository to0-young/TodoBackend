
Rails.application.configure do
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3001'
      resource '*', credentials: true, headers: :any, methods: [:get, :post, :patch, :put, :delete]
    end
  end
  config.hosts << "*"
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins Rails.application.credentials[:front_end_url] || ''
      resource '*', credentials: true, headers: :any, methods: [:get, :post, :patch, :put, :delete]
    end
  end
end
