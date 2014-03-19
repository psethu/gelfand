class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :individual_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
