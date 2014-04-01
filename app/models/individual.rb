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
    #validates :role, :presence => true, :numericality => {:only_integer => true, :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0}
    
    validates_date :dob, :on_or_before => lambda {Date.current}


    scope :alphabetical, order('l_name, f_name')
    scope :active, where('active = ?', true)
    scope :no_bg_check, where('bg_check_id IS NULL')

    def name
    	"#{l_name}, #{f_name}"
    end

end
