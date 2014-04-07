class RemoveContactIdFromIndividuals < ActiveRecord::Migration
  def change
    remove_column :individuals, :contact_id, :integer
  end
end
