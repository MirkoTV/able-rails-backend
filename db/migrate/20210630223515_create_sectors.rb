class CreateSectors < ActiveRecord::Migration[6.1]
  def change
    create_table :sectors do |t|
      t.references :lap
      t.references :driver

      t.integer :time

      t.timestamps
    end
  end
end
