class RemoveDateApprovedFromBgCheck < ActiveRecord::Migration
  def change
    remove_column :bg_checks, :date_approved, :date
  end
end
