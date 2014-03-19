class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :phone
      t.string :email
      t.string :nickname
      t.text :notes
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
