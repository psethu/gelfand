class Organization < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :contacts
    has_many :affiliations
    has_many :programs, through: :affiliations
    has_many :org_users
    has_many :memberships
    has_many :individuals, through: :memberships
end
