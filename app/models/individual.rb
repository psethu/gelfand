class Individual < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :contact
    has_many :memberships
    has_many :organizations, through: :memberships
    has_many :participants
    has_many :programs, through: :participants
    has_one :bg_check


    validates :f_name, :presence => true
    validates :l_name, :presence => true
    validates_presence_of :active
    validates :contact_id, :numericality => { :only_integer => true }, :allow_blank => true

    #TBD by future ERD
    validates :role, :presence => true, :numericality => {:only_integer => true, :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0}


    # Callbacks
    # ---------
    before_create :set_defaults

    # Scopes
    # ------
    default_scope { where(active: true)}
    scope :alphabetical, -> { order('l_name') }
    scope :alpha_by_first, -> { order('f_name') }
    scope :students, -> { where(role: 0) }
    scope :faculty, -> { where(role: 1) }
    scope :off_campus, -> { where(role: 2) }
    scope :inactive, -> { where(active: false) }
    scope :no_bg_check, -> { where(bg_check_id: nil) }

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

	def name
		"#{l_name}, #{f_name}"
	end

	def proper_name
		"#{f_name} #{l_name}"
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
