class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :organization_id
      t.integer :program_id
      t.text :description
      t.boolean :followed_process

      t.timestamps
    end
  end
end
