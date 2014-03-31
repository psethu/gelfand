class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    has_one :contact
    has_many :memberships
    has_many :organizations, through: :memberships
    has_many :participants
    has_many :programs, through: :participants
    has_one :bg_check

    # Callbacks
    # ---------
    before_create :set_defaults

    # Scopes
    # ------
    scope :alphabetical, order('name')
    scope :active, where('active = ?', true)
    scope :inactive, where('active = ?', false)

    # Class Methods
    # -------------

    def format_role
    	case self.role
    	when 0
    		return "Student"
		when 1
			return "Faculty"
		when 2
			return "Off-Campus"
		else
			return "attr_error"
    	end
    end

    # Private Methods
    # ---------------
    private
    	def set_defaults
    		self.active = true
    		self.bg_check = nil
    		self.contact_id = nil
    	end
end
