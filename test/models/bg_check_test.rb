require 'test_helper'

class BgCheckTest < ActiveSupport::TestCase
	# Test Relationships
	should belong_to(:individual)

	# Test Validations

	# Status
	should allow_value(0).for(:status)
	should_not allow_value("nope").for(:status)
	should_not allow_value(8).for(:status)

	# Dates
	should allow_value(Date.today).for(:date_requested)
	should_not allow_value(3.days.from_now).for(:date_requested)

	should "not allow insequential dates" do
		bad_check = FactoryGirl.build(:bg_check, criminal_date: 15.days.ago)
		deny bad_check.valid?

		bad_check = FactoryGirl.build(:bg_check, criminal_date: 2.days.ago, child_abuse_date: 7.days.ago)
		deny bad_check.valid?
	end


	context "Initial BG_Check Test" do
		setup do
			create_bg_checks_context
		end

		# Attribute Formatting

		should "format status of background check correctly" do
			
		end


		teardown do
			remove_bg_checks_context
		end
	end
end
