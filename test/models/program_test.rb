require 'test_helper'

class ProgramTest < ActiveSupport::TestCase

	# Test Relationships
	# -------------

	should belong_to(:contact)

	should have_many(:participants)
	should have_many(:individuals).through(:participants)
	should have_many(:affiliations)
	should have_many(:organizations).through(:affiliations)

	# Test Validations
	# ----------------

	should validate_presence_of(:name)
	should allow_value(5).for(:num_minors)
	should_not allow_value(-1).for(:num_minors)
	should_not allow_value("<script type=javascript>").for(:num_minors)

	should validate_date(:start_date).after(:end_date)

	context "Initial Programs Test" do

		setup do
			create_programs_context
		end

		should "list programs alphabetically" do

		end

		should "list upcoming programs" do

		end

		should "list completed programs" do

		end

		teardown do
			remove_programs_context
		end

	end

end
