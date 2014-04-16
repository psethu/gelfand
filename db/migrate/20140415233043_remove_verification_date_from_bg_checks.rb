class RemoveVerificationDateFromBgChecks < ActiveRecord::Migration
  def change
    remove_column :bg_checks, :verification_date, :date
  end
end
