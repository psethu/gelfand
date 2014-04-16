class AddActualIndividualIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :individual_id, :integer
  end
end
