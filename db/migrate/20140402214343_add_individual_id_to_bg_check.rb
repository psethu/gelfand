class AddIndividualIdToBgCheck < ActiveRecord::Migration
  def change
    add_column :bg_checks, :bg_check_id, :integer
  end
end
