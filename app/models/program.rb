class Program < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :participants
    has_many :individuals, through: :participants
    has_many :affiliations
    has_many :organizations, through: :affiliations
    belongs_to :contact
    
    validates :name, :presence => true
    validates :num_minors, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

    validates_date :start_date, :presence => true
    validates_date :end_date, :allow_blank => true, :after => :start_date

    

end
