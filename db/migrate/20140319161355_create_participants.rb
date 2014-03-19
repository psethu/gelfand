class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :program_id
      t.integer :individual_id

      t.timestamps
    end
  end
end
