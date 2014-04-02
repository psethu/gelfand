class BgCheck < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :individual

    # Scopes
    # ------
    scope :started, where('status = ?', 0)
    scope :processing, where('status = ?', 1)
   	scope :complete, where('status = ?', 2)

   	# Class Methods
   	# -------------

   	def complete?
   		return self.status == 2
   	end

end
