class User < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :org_users
    has_many :organizations, through: :org_users
    belongs_to :individual

    # The below scope probably unecessary but could be useful in future
    # scope :for_individual, lambda {|individual_id| where("individiual_id = ?", individual_id) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
  	admin # this is a boolean that holds a true or false value
  end

  def member?
  	member # this is a boolean that holds a true or false value
  end

  # have to do "== []" check because self.org_users returns empty array not 'nil' if empty
  def get_org_ids
    if self.org_users == []
      return nil
    end
    self.org_users.map{|ou| ou.organization_id}
  
  end

  def get_orgs
    if self.org_users == []
      return nil
    end
    self.get_org_ids.map { |oi| Organization.find(oi) }
  end

  def get_admin_prog_ids
    prog_ids = []
    org_ids = self.get_org_ids
    org_ids.each do |oi|
      Organization.find(oi).affiliations.each do |affiliation|
        prog_ids << affiliation.program_id
      end
    end
    
    if prog_ids == [] 
      return nil
    end
    prog_ids
  end

  def get_programs_for_an_org(org)
      if org.affiliations == []
          return nil
      end
      programs = []
      org.affiliations.each do |affiliation|
        programs << Program.find(affiliation.program_id)
      end
      programs
  end

  def get_member_prog_ids
    self.individual.participants.map{|p| p.program_id}
  end

  def get_bg_check_id
    self.individual.bg_check.id
  end

  def get_first_name
    Individual.find(self.individual_id).f_name
  end  

  def get_bgCheck
      bgObject = self.individual.bg_check
      if bgObject.nil?
        return nil
      end
        return bgObject
  end


end
