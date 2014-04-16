class AddContactIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :contact_id, :integer
  end
end
