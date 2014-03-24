class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :contact
    has_many :memberships
    has_many :participants
    belongs_to :bg_check
end
