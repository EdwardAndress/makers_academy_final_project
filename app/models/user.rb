class User < ActiveRecord::Base

	has_one :oauth_credential

	def self.find_or_create_from_auth_hash(auth_hash)
		# case auth_hash["moves"]
		# when 'moves'
		uid = auth_hash["uid"].to_s
		credentials = ::OauthCredentials.find_or_create_by(uid: uid)
		credentials.attributes = {
			token: auth_hash["credentials"]["token"],
			refresh_token: auth_hash["credentials"]["refresh_token"],
			expires_at: Time.at(auth_hash["credentials"]["expires_at"]),
		}
		credentials.user ||= User.create
		credentials.save!
		# else
		# 	raise "unknown provider!"
		# end

		credentials.user
	end

	has_one :moves_oauth_credentials
	has_many :oauth_credentials, class_name: ::OauthCredentials

	def moves
		@moves ||= Moves::Client.new(moves_oauth_credentials.token)
	end
end