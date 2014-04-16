class RemoveBgCheckIdFromBgCheck < ActiveRecord::Migration
  def change
    remove_column :bg_checks, :bg_check_id, :integer
  end
end
