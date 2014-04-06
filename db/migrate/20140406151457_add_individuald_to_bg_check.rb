class AddIndividualdToBgCheck < ActiveRecord::Migration
  def change
    add_column :bg_checks, :individual_id, :integer
  end
end
