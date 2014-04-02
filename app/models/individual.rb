class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    has_one :contact
    has_many :memberships
    has_many :organizations, through: :memberships
    has_many :participants
    has_many :programs, through: :participants
    has_one :bg_check


    validates :f_name, :presence => true
    validates :l_name, :presence => true

    #TBD by future ERD
    validates :role, :presence => true, :numericality => {:only_integer => true, :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0}
    
    validates_date :dob, :on_or_before => lambda {Date.current}



    


    # Callbacks
    # ---------
    before_create :set_defaults

    # Scopes
    # ------
    scope :alphabetical, order('name')
    scope :active, where('active = ?', true)
    scope :inactive, where('active = ?', false)
    scope :no_bg_check, where('bg_check_id IS NULL')

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

    	def name
    		"#{l_name}, #{f_name}"
    	end

end
