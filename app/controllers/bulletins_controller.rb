require Rails.root.join('lib', 'data_handling', 'formatted_data.rb')
require Rails.root.join('lib', 'data_handling', 'compare_timelines.rb')
require Rails.root.join('lib', 'data_handling', 'timeline.rb')
require Rails.root.join('lib', 'data_handling', 'convert_timestamp.rb')
# require Rails.root.join('lib', 'bulletin.rb')

class BulletinsController < ApplicationController

	def index

		users = (User.all)

		if current_user && current_user.has_friends?
			@bulletins = current_user.bulletins_list
		elsif current_user && !current_user.all_following.any?
			redirect_to users_path
		else
			redirect_to '/auth/facebook'
		end

	end

end
