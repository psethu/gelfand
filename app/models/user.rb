class User < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :org_users
    has_many :organizations, through: :org_users
    has_one :individual
    accepts_nested_attributes_for :individual


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
  def org_ids_that_user_is_orgUser_for
    if self.org_users == []
      return nil
    end
    self.org_users.map{|ou| ou.organization_id}
  
  end

  def is_orgUser_for_specific_org(org)
    # if below if cond. nil then user isnt an OrgUser for any org
      if self.org_ids_that_user_is_orgUser_for == nil
        return false
      end
    org_ids = self.org_ids_that_user_is_orgUser_for
    # Below: if there is a match, then User is an orgUser (admin for the Org) for given org
    org_ids.include?(org.id)
  end

  # get all memberships for a user (Whether the user is a regular User or OrgUser)
  def get_all_memberships
    unless self.individual.nil?
      return Membership.for_individual(self.individual.id)
    end
    return []
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
    org_ids = self.org_ids_that_user_is_orgUser_for
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

  # method assumes: Org has at least 1 affiliation
  #                 User has at least 1 participation                
  def get_all_programs_user_not_yet_participating_in_under_an_org(org)

    # all_affiliations gets ALL affiliations to programs for 1 org
    affiliated_programs = org.affiliations.map {|affil| Program.find(affil.program_id)}

    dups = self.get_programs_user_participating_under_particular_org(org)
    # return immediately since user not participating in any of orgs programs

    if dups.empty?
        return dups
    end

    affiliated_programs - dups
  end

  # method assumes: Org has at least 1 affiliation
  #                 User has at least 1 participation
  def get_programs_user_participating_under_particular_org(org)
    # all_participations: gets ALL participations to programs from ANY org
    all_participations = self.individual.participants
    # all_affiliations: gets ALL affiliations to programs for 1 org
    all_affiliations = org.affiliations

    # get program_ids from each above
    p_ids_prtcpnts = all_participations.map {|prtcpnt| prtcpnt.program_id}
    p_ids_affils = all_affiliations.map {|affil| affil.program_id}

    # get the program_ids that overlap in the above
      # '&' will return nil if there are no duplicates else returns array with dup elemnts
    p_ids = p_ids_prtcpnts & p_ids_affils

    # return a list of programs from each id
    p_ids.map{|p_id| Program.find(p_id)}
  end

end
