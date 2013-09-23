require 'spec_helper'

describe 'home page', :js => true do

	#, :driver => :webkit
	it 'signs in the user' do
		FactoryGirl.create(:user)
		visit '/#login'
		within("#login") do
			fill_in 'username', :with => 'dummy'
			fill_in 'password', :with => 'dummy'
		end
		click_button 'Log In'
		expect(page).to have_content 'Employees List'
		sleep 5.seconds
	end

end