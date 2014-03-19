class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.text :cmu_facilities
      t.text :off_campus_facilities
      t.integer :num_minors
      t.integer :num_adults_supervising
      t.integer :irb_approval
      t.integer :contact_id

      t.timestamps
    end
  end
end
