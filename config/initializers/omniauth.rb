OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :facebook, '1270506772973041', 'bda787844be1024175878b6aa8a64e33', {:provider_ignores_state => true}
      provider :facebook, '1270506772973041', 'bda787844be1024175878b6aa8a64e33', 
		{:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}, :provider_ignores_state => true}
end
