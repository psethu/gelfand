class ChangeUserIndividualRelationship < ActiveRecord::Migration
  def change
    remove_column :users, :individual_id, :integer
    add_column :individuals, :user_id, :integer
  end
end
