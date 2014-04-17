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
		indiv = FactoryGirl.build(:individual)

		bad_check = FactoryGirl.build(:bg_check, individual_id: indiv.id, criminal_date: 15.days.ago)
		deny bad_check.valid?

		bad_check = FactoryGirl.build(:bg_check, individual_id: indiv.id, criminal_date: 2.days.ago, child_abuse_date: 7.days.ago)
		deny bad_check.valid?
	end

	should "automatically change the status if dates are updated" do
		indiv = FactoryGirl.create(:individual)
		check = FactoryGirl.build(:bg_check, individual_id: indiv.id)

		check.criminal_date = 5.days.ago
		check.save!

		assert_equal(check.status, 1)
		indiv.delete
		check.delete
	end

	context "Initial BG_Check Test" do
		setup do
			create_bg_checks_context
		end

		# Attribute Formatting

		should "format status of background check correctly" do
			status = "Requested"
			assert_equal(status, @standard.format_status)

			status = "Child Abuse Passed"
			assert_equal(status, @passed_child_abuse.format_status)
		end

		should "show whether or not a background check is completed" do
			assert @ronswan.bg_check.complete?

			deny @tammy.bg_check.complete?
		end

		# Scopes and Sorting

		should "return correct background checks for given scopes" do
			assert_equal(BgCheck.requested.map(&:id), @requested)

			assert_equal(BgCheck.passed_criminal.map(&:id), @crim_passed)

			assert_equal(BgCheck.passed_child_abuse.map(&:id), @abuse_passed)
		end

		teardown do
			remove_bg_checks_context
		end
	end
end
