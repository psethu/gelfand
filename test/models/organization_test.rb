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

		teardown do
			remove_organization_context
		end
		
	end

end
