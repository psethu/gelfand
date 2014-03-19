class CreateBgChecks < ActiveRecord::Migration
  def change
    create_table :bg_checks do |t|
      t.date :date_approved
      t.integer :status
      t.date :criminal_date
      t.date :child_abuse_date
      t.date :verification_date

      t.timestamps
    end
  end
end
