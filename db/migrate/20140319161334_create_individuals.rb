class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals do |t|
      t.string :f_name
      t.string :l_name
      t.integer :role
      t.date :dob
      t.boolean :active
      t.integer :bg_check_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
