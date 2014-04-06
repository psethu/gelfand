class RemoveDobFromIndividuals < ActiveRecord::Migration
  def change
    remove_column :individuals, :dob, :date
  end
end
