class AddRoleToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :role, :integer
  end
end
