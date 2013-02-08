require 'openssl'
require 'json'
require 'patron'
require 'instagram'

KEY = "IMyYiubXP5Jx5lTLdVLWQZjeLEuA3WPnE4xyvVGY+bnaRcVsRjtV3jEAzJ/jwAme"
DEVICE_ID = "2A233096-5358-4AB1-97A7-13D5ABF9FBEA"
USER_AGENT = "Instagram 3.2.0 Android (10/2.3.7; 240dpi; 480x800; HTC/htc_wwe; HTC Desire"
BASE_URL = "https://instagram.com"

def login(params={})
	username = params[:username]
	password = params[:password]

	login_info = {:username => username, 
		:password => password, 
		:device_id => DEVICE_ID}.to_json
	checksum = Digest::HMAC.hexdigest(login_info, KEY, Digest::SHA256)
	signed_body = "#{checksum}.#{login_info}"
	post_data = {:signed_body => signed_body, :ig_sig_key_version => 2}

	puts login_info
	puts checksum

	sess = Patron::Session.new
	sess.base_url = BASE_URL
	sess.headers["User-Agent"] = USER_AGENT
	# config.client_secret = "88667e3f09c144dbb85f7f9444f7e262"
	# config.client_id = "16fa000f7f144cafb9fc13804d75fb2a"
	sess.post('/api/v1/accounts/login/', post_data)
	return sess, post_data
end