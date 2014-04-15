class BgCheck < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :individual
    
	# Validations
	# -----------
  	validates :status, :presence => true, :numericality => {:only_integer => true, :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0}
    validates :individual_id, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0 }
    validates_date :date_requested, :allow_blank => false
    validates_date :criminal_date, :after => :date_requested, :allow_blank => true
    validates_date :child_abuse_date, :after => :criminal_date, :allow_blank => true

    # Callbacks
    # ---------

    before_create :give_initial_date

    # Scopes
    # ------
    scope :started, -> { where('status = ?', 0) }
    scope :processing, -> { where('status = ?', 1) }
   	scope :complete, -> { where('status = ?', 2) }

   	# Class Methods
   	# -------------

   	def complete?
   		return self.status == 2
   	end
    
    private

    # Method to set the request date to the current date if there is no given date
    def give_initial_date
        unless date_requested
            self.date_requested = Date.today
        end

end
