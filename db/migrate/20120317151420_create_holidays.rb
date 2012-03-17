class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :holiday_for
      t.datetime :holiday_date
      t.references :users

      t.timestamps
    end
    add_index :holidays, :users_id
  end
end
