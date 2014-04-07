class RemoveContactIdFromPrograms < ActiveRecord::Migration
  def change
    remove_column :programs, :contact_id, :integer
  end
end
