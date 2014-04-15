require 'test_helper'

class BgCheckTest < ActiveSupport::TestCase
	#Test Relationships


	#Test Validations


	context "Initial BG_Check Test" do
		setup do
			create_bg_checks_context
		end

		

		teardown do
			remove_bg_checks_context
		end
	end
end
