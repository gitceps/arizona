OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
<<<<<<< HEAD
  provider :facebook, '284400331936514', '9b435badb33e78ea0ac2c7b79692bbce', 
    scope: 'email,user_birthday,read_stream', display: 'popup'
end
=======
 # provider :facebook, '1270506772973041', 'bda787844be1024175878b6aa8a64e33', {:provider_ignores_state => true}
      provider :facebook, '1270506772973041', 'bda787844be1024175878b6aa8a64e33', 
		{:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}, :provider_ignores_state => true}
end
>>>>>>> cc4d70b2c9131987f03889e3846526f598f44891
