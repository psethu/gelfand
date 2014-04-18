require 'test_helper'

class UserTest < ActiveSupport::TestCase

	# Test Relationships

	should belong_to(:individual)
	should have_many(:org_users)
	should have_many(:organizations).through(:org_users)



 	context "Initial User Context" do

 		setup do
 			create_users_context
 		end

 		should "sign in and sign out" do
 			sign_in @default
 			assert user_signed_in?

 			sign_out @default
 			deny user_signed_in?
		end	

 		should "show whether or not someone is an admin" do
 			assert @admin.admin?
 			deny @default.admin?
 		end

 		teardown do
 			remove_users_context
 		end
 	end

 	

end
