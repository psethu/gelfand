class Affiliation < ActiveRecord::Base
    
    # Relationships
    # -------------
    belongs_to :organization
    belongs_to :program
end
