class Membership < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :individual
    belongs_to :organization

    scope :for_individual, lambda {|individual_id| where("individual_id = ?", individual_id) }
    scope :for_organization, lambda {|organization_id| where("organization_id = ?", organization_id) }

    #Validations
    validates_numericality_of :individual_id, :only_integer => true
    validates_numericality_of :organization_id, :only_integer => true 

    private

    def organization_is_active_in_system
        active_organization_ids = Organization.active.all.map{|a| a.id}
        unless active_organization_ids.include?(self.organization_id)
            errors.add(:organization, "is not an active organization in system")
        end
    end

    def individual_is_active_in_system
        active_individual_ids = Individual.active.all.map{|i| i.id}
        unless active_individual_ids.include?(self.individual_id)
            errors.add(:individual, "is not an active individual in system")
        end
    end

    def membership_is_not_already_in_system
        return true if self.individual_id.nil? || self.organization_id.nil?
        possible_repeat = Memebership.where(organization_id: organization_id, student_id: student_id)
        unless possible_repeat.empty?
            errors.add(:individual_id, "is already a member of this organization")
        end
    end
end
