class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    has_one :contact
    has_many :memberships
    has_many :organizations, through: :memberships
    has_many :participants
    has_many :programs, through: :participants
    has_one :bg_check

end
