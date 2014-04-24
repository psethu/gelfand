class Program < ActiveRecord::Base



    # Relationships
    # ------------- 
    has_many :participants
    has_many :individuals, through: :participants
    has_many :affiliations
    has_many :organizations, through: :affiliations
    belongs_to :contact

    # Validations
    # -----------
    
    validates :name, :presence => true
    validates :num_minors, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

    validates_date :start_date, :presence => true
    validates_date :end_date, :allow_blank => true, :after => :start_date

    # Scopes
    # ------

    scope :alphabetical, -> { order('name') }
    scope :future, -> { where('start_date > ?', Date.today) }
    scope :past, -> { where('start_date <= ?', Date.today) }
    scope :upcoming, -> { future.order('start_date ASC') }
    scope :current, -> { past.where('end_date > ?', Date.today) }
    scope :completed, -> { where('end_date <= ?', Date.today) }

    # Class Methods
    # -------------

    def individuals_without_bg_check
        self.individuals.select{ |i| i.bg_check.nil? }
    end

    def num_individuals_without_bg_check
        self.individuals_without_bg_check.count
    end

    def num_cleared_participations
        self.individuals.count - self.individuals_without_bg_check
    end

    def cleared_participations
        
    end

    def individuals_in_org(org_id)
        org = self.organizations.find_by id: org_id
        self.individuals.select{ |i| org.is_member?(i.id) }
    end

    def individuals_in_org_without_bg_check(org_id)
        self.individuals_in_org(org_id).select{ |i| i.bg_check.nil? }
    end
end
