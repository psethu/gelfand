class Organization < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :contact
    has_many :affiliations
    has_many :org_users
    has_many :memberships
end
