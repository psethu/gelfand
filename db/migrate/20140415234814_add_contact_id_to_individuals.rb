class AddContactIdToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :contact_id, :integer
  end
end
