class Participant < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :program
    belongs_to :individual
end
