require 'rails_helper'


describe "access page" do
	before(:all) do
		OmniAuth.config.test_mode = true
		OmniAuth.config.mock_auth[:moves] = OmniAuth::AuthHash.new(
			{
				:uid => '123456789',
				:credentials => { :token => '12345', :expires_at => 1.week.from_now }
			}
		)

	end

	after(:all) do
		OmniAuth.config.test_mode = false
	end

	before do
		User.create(uid: '123456789')
	end

	it "can sign in user with Moves account" do
		visit '/auth/moves'
		expect(page).to have_link 'Log out'
	end
end
