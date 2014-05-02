class Contact < ActiveRecord::Base

    # Relationships

    STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]
    
    #Valiations
    validates_format_of :phone, :with => /A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}Z/, :message => "should be 10 digits (area code needed) and delimited with dashes only", :allow_blank => true
    #validates_uniqueness_of :email, :case_sensitive => false
    #validates_format_of :email, :with => /A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))Z/i, :message => "is not a valid format"

    #validates_presence_of :street, :city, :state, :zip, if: :address?
    validates_inclusion_of :state, :in => STATES_LIST.map {|k, v| v}, :message => "is not a recognized state in the system", :allow_blank => true
    validates_format_of :zip, :with => /A\d{5}Z/, :message => "should be five digits long", :allow_blank => true
    #Scopes

    #CONTACTS_LIST = Contact.all.map { |c| [c.title, city.id] }

    private
      def reformat_phone
        phone = self.phone.to_s  # change to string in case input as all numbers 
        phone.gsub!(/[^0-9]/,"") # strip all non-digits
        self.phone = phone       # reset self.phone to new string
      end

      def address?
        if street || street2 || city || state || zip 
            return true
        end
        return false  
      end
end
