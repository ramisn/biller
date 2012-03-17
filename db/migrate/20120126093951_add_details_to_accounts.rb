class AddDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :email, :string
    add_column :accounts, :phone, :string
  end
end
