class CreateDrivers < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers do |t|
      t.references :team

      t.string :first_name
      t.string :last_name
      t.string :ui_name
      t.integer :number
      t.integer :all_time_best

      t.timestamps
    end
  end
end
