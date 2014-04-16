class AddDateRequestedToBgChecks < ActiveRecord::Migration
  def change
    add_column :bg_checks, :date_requested, :date
  end
end
