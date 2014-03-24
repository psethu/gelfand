class Program < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :participants
    has_many :affiliations
    
end
