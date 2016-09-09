OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '284400331936514', '9b435badb33e78ea0ac2c7b79692bbce', 
    scope: 'email,user_birthday,read_stream', display: 'popup'
end