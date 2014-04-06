class RemoveBgcheckIdFromIndividual < ActiveRecord::Migration
  def change
    remove_column :individuals, :bg_check_id, :integer
  end
end
