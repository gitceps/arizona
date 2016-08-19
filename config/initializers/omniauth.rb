OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '284400331936514', '9b435badb33e78ea0ac2c7b79692bbce', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end