class Program < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :participants
    has_many :individual, through: :participants
    has_many :affiliations
    has_many :organizations, through: :affiliations
    
end
