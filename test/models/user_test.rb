require 'test_helper'

class ActionController::TestCase
    include Devise::TestHelpers
end

class UserTest < ActiveSupport::TestCase

	# Test Relationships

	should belong_to(:individual)
	should have_many(:org_users)
	should have_many(:organizations).through(:org_users)



 	context "Initial User Context" do

 		setup do
 			create_users_context
 		end

 		should "show whether or not someone is an admin" do
 			assert @admin.admin?
 			deny @default.admin?
 		end

 		should "know which programs this user is running" do
 			sign_in @admin
 		end

 		teardown do
 			remove_users_context
 		end
 	end

 	

end
