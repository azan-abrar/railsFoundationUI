require 'spec_helper'

describe 'home page', :js => true do

	#, :driver => :webkit
	it 'signs in the user', :driver => :webkit do
		FactoryGirl.create(:user)
		visit '/#login'
		within("#login") do
			fill_in 'username', :with => 'dummy'
			fill_in 'password', :with => 'dummy'
		end
		click_button 'Log In'
		expect(page).to have_content 'Employees List'
		sleep 2.seconds

		within("#searchEmployees") do
			fill_in 'searchField', :with => 'Engineer'
		end
		click_link 'Search'
		sleep 2.seconds
		
	end

end