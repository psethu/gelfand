class CreateOrgUsers < ActiveRecord::Migration
  def change
    create_table :org_users do |t|
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
