class Membership < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :individual
    belongs_to :organization

end
