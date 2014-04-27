class User < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :org_users
    has_many :organizations, through: :org_users
    has_one :individual
    accepts_nested_attributes_for :individual
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

  def has_individual?
    return !self.individual.nil?
  end

  # have to do "== []" check because self.org_users returns empty array not 'nil' if empty
  def get_org_ids
    if self.org_users == []
      return nil
    end
    self.org_users.map{|ou| ou.organization_id}
  
  end

  def is_orgUser_for_specific_org(org)
    # if below if cond. nil then user isnt an OrgUser for any org
      if self.get_org_ids == nil
        return false
      end
    org_ids = self.get_org_ids
    # Below: if there is a match, then User is an orgUser (admin for the Org) for given org
    org_ids.include?(org.id)
  end

  # get all memberships for a user (Whether the user is a regular User or OrgUser)
  def get_all_memberships
      Membership.for_individual(self.individual_id)
  end


# get all organizations a person is a part of (Whether the user is a regular User or OrgUser)
# assumes get_all_memberships returns at least 1 membership
  def orgs_that_user_is_part_of
      orgIds = self.get_all_memberships.map {|mem| mem.organization_id}
      orgIds.map{|oi| Organization.find(oi) }
  end

  # get all orgs that current_user is an OrgUser to
  def orgs_that_user_is_Admin_for
      if self.org_users == []
        return []
      end
      # user is an OrgUser for at least 1 org
      self.org_users.map{|org_user| Organization.find(org_user.organization_id)}
  end

  def get_admin_prog_ids
    prog_ids = []
    org_ids = self.get_org_ids
    if org_ids.nil?
      return nil
    end
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
    if self.has_individual?
        return self.individual.f_name
    end
    return "User"
  end  

  def get_bgCheck
    unless self.individual.nil?
      bgObject = self.individual.bg_check
      if bgObject.nil?
        return nil
      end
        return bgObject
    end
    return nil
  end


end
