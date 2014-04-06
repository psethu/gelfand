class RemoveRoleFromIndividual < ActiveRecord::Migration
  def change
    remove_column :individuals, :role, :integer
  end
end
