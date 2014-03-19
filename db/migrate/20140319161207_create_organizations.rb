class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.boolean :is_partner
      t.text :description
      t.boolean :active
      t.string :department
      t.integer :contact_id

      t.timestamps
    end
  end
end
