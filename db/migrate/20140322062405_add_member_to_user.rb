class AddMemberToUser < ActiveRecord::Migration
  def change
	add_column :users, :member, :boolean, :default => true
  end
end
