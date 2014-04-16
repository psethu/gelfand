class RemoveUserIdFromIndividual < ActiveRecord::Migration
  def change
    remove_column :individuals, :user_id, :integer
  end
end
