class BgCheck < ActiveRecord::Base

    # Relationships
    # -------------
    belongs_to :individual

     validates :status, :presence => true, :numericality => {:only_integer => true, :less_than_or_equal_to => 2, :greater_than_or_equal_to => 0}
     validates :individual_id, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

     validates_date :criminal_date, :allow_blank => true
     validates_date :child_abuse_date, :after => :criminal_date, :allow_blank => true
     validates_date :date_approved, :after => :child_abuse_date, :allow_blank => true
     #Not sure what verification date is 

end
