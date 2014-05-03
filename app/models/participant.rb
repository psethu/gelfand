class Participant < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :program
    belongs_to :individual

    #validations
    validates_numericality_of :program_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :individual_id, :only_integer => true, :greater_than => 0
    #validate :program_is_active_in_system, :on => :create
    #validate :individual_is_active_in_system, :on => :create
    #validate :participant_is_not_already_in_system, :on => :create

    #scopes
    scope :for_program, lambda {|program_id| where("program_id = ?", program_id)}
    scope :for_individual, lambda {|individual_id| where("individual_id = ?", individual_id)}

    private
    def program_is_active_in_system
        active_program_ids = Program.active.all.map{|a| a.id}
        unless active_program_ids.include?(self.program_id)
            errors.add(:prgram, "is not an active organization in system")
        end
    end

    def individual_is_active_in_system
        active_individual_ids = Individual.active.all.map{|i| i.id}
        unless active_individual_ids.include?(self.individual_id)
            errors.add(:individual, "is not an active individual in system")
        end
    end

    def participant_is_not_already_in_system
        return true if self.individual_id.nil? || self.program_id.nil?
        possible_repeat = Memebership.where(program_id: organization_id, student_id: student_id)
        unless possible_repeat.empty?
            errors.add(:individual_id, "is already a member of this organization")
        end
    end
end
