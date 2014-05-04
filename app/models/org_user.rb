class OrgUser < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :user
    belongs_to :organization

    #valdiations
    validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :organization_id, :only_integer => true, :greater_than => 0

    # Scopes
    scope :for_organization, lambda {|organization_id| where("organization_id = ?", organization_id) }

=begin
README
Had to comment this out otherwise I get error 'no active method exists for class'
when I create the org_user by default when the current_user creates an Organization

    validate :organization_is_active_in_system, :on => :create
    validate :user_is_active_in_system, :on => :create
    validate :org_user_is_not_already_in_system, :on => :create

    private
    def organization_is_active_in_system
        active_organization_ids = Organization.active.all.map{|a| a.id}
        unless active_organization_ids.include?(self.organization_id)
            errors.add(:organization, "is not an active organization in system")
        end
    end

    def user_is_active_in_system
        active_user_ids = User.active.all.map{|u| u.id}
        unless active_user_ids.include?(self.organization_id)
            errors.add(:user, "is not an active organization in system")
        end
    end

    def org_user_is_not_already_in_system
        return true if self.user_id.nil? || self.organization_id.nil?
        possible_repeat = Memebership.where(organization_id: organization_id, user_id: user_id)
        unless possible_repeat.empty?
            errors.add(:user_id, "is already an org_user of this organization")
        end
    end
=end
    
end
