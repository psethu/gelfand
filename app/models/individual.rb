class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :contact
    has_many :memberships
    has_many :organizations, through: :memberships
    has_many :participants
    has_many :projects, through: :participants
    has_one :bg_check
end
