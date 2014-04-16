require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
	
	# Test Relationships
	should belong_to(:contact)
	
	should have_many(:affiliations)
	should have_many(:programs).through(:affiliations)
	should have_many(:memberships)
	should have_many(:individuals).through(:memberships)
	should have_many(:org_users)
	should have_many(:users).through(:org_users)

	# Test Validations

	should validate_presence_of(:name)
	should validate_presence_of(:department)
	should validate_presence_of(:description)
	should validate_uniqueness_of(:name)

	context "Initial Organization Context" do

		setup do
			create_organization_context
		end

		# Attribute Formatting

		should "ensure that the department name contains only alphabetical characters" do
			@bad_dept = FactoryGirl.build(:organization, name: "Bad Department Org", department:"Th3 R3d Cr0ss", description: "This is just all wrong")
			deny @bad_dept.valid?
		end

		# Scopes and Sorting

		should "sort organizations alphabetically" do
			list = Organization.alphabetical.map(&:name)
			assert_equal(list, @alpha_list)
		end

		should "filter partner and CMU organizations correctly" do
			list = Organization.partner_orgs.sort_by!{ |o| o.name.downcase }.map(&:name)
			assert_equal(list, @partners_list)

			list = Organization.cmu_orgs.sort_by!{ |o| o.name.downcase }.map(&:name)
			assert_equal(list, @non_partners_list)
		end

		should "be able to look up inactive orgs" do
			list = Organization.inactive.sort_by!{ |o| o.name.downcase }.map(&:name)
			assert_equal(list, @inactive_orgs)
		end

		teardown do
			remove_organization_context
		end
		
	end

end
