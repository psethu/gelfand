require 'test_helper'

class IndividualTest < ActiveSupport::TestCase
	# Test Relationships
	should belong_to(:contact)
	should have_one(:bg_check)

	should have_many(:participants)
	should have_many(:programs).through(:participants)
	should have_many(:memberships)
	should have_many(:organizations).through(:memberships)



  	# Test Validations

  	should validate_presence_of(:f_name)
  	should validate_presence_of(:l_name)
  	should validate_presence_of(:role)

    should allow_value(2).for(:role)
    should_not allow_value("bad").for(:role)

  	context "Initial Individual Context" do
  		setup do
  			create_individual_context
  		end

  		# Attribute Formatting

  		should "format names in a (last, first) format" do
  			name = "Payne, Max"
  			assert_equal(name, @max.name)
  		end

  		should "format proper names" do
  			name = "John Doe"
  			assert_equal(name, @standard.proper_name)
  		end

  		should "format roles correctly" do
            		role = "Student"
         		assert_equal(role, @standard.format_role)

  			role = "Faculty"
  			assert_equal(role, @dave.format_role)

            		role = "Off-Campus"
            		assert_equal(role, @max.format_role)
  		end

  		# Scopes and Sorting

  		should "alphabetize by first name" do
  			list = Individual.alpha_by_first.map(&:f_name)
  			assert_equal(list, @alphabetical_by_first)
  		end

  		should "alphabetize by last name" do
  			list = Individual.alphabetical.map(&:f_name)
  			assert_equal(list, @alphabetical_by_last)
  		end

  		should "list users by specific role" do
  			list = Individual.students.sort_by!{ |i| i.l_name.downcase }.map(&:f_name)
            		assert_equal(list, @students_only)

            		list = Individual.faculty.sort_by!{ |i| i.l_name.downcase }.map(&:f_name)
            		assert_equal(list, @faculty_only)

            		list = Individual.off_campus.sort_by!{ |i| i.l_name.downcase}.map(&:f_name)
            		assert_equal(list, @off_campus_only)
  		end

  		teardown do
  			remove_individual_context
  		end
	  	
  	end
end
