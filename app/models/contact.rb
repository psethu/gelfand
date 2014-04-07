class Contact < ActiveRecord::Base

    # Relationships
    belongs_to :individual
    belongs_to :organization
    belongs_to :program
    # ------------- not sure how to do this exactly

end
