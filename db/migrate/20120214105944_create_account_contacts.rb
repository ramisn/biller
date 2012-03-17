class CreateAccountContacts < ActiveRecord::Migration
  def change
    create_table :account_contacts do |t|
      t.references :account
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
