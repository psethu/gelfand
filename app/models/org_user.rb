class OrgUser < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :user
    belongs_to :organization
    
end
