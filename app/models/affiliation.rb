class Affiliation < ActiveRecord::Base
    
    # Relationships
    # -------------
    belongs_to :organization
    belongs_to :program

    scope :for_organization, lambda {|organization_id| where("organization_id = ?", organization_id)}
    scope :for_program, lambda {|program_id| where("program_id = ?", program_id)}

    validates_numericality_of :organization_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :program_id, :only_integer => true, :greater_than => 0

=begin
Commenting this stuff out for now because otherwise cant save Affiliation in database (currently done in program controller show action)
    validate :organization_is_active_in_system, :on => :create
    validate :program_is_active_in_system, :on => :create
    validate :affiliation_is_not_alread_in_system, :on => :create

    private
    def organization_is_active_in_system
        active_organization_ids = Organization.active.all.map{|a| a.id}
        unless active_organization_ids.include?(self.organization_id)
            errors.add(:organization, "is not an active organization in system")
        end
    end

    def program_is_active_in_system
        active_program_ids = Program.active.all.map{|p| p.id}
        unless active_program_ids.include?(self.organization_id)
            errors.add(:program, "is not an active program in system")
        end
    end

    def affliation_is_not_already_in_system
        return true if self.organization_id.nil? || self.program_id.nil?
        possible_repeat = Affliation.where(organization_id: organization_id, program_id: program_id)
        unless possible_repeat.empty?
            errors.add(:program_id, "is already a part of this organization")
        end
    end
=end

end
