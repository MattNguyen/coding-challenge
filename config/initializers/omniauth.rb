Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,'470247609666517', 'ea8eb2558cc6b916cc9ff13ab5458fc8', { :scope => "read_stream, user_status" } 
end
