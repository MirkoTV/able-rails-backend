class CreateLaps < ActiveRecord::Migration[6.1]
  def change
    create_table :laps do |t|
      t.references :performance
      t.references :driver

      t.integer :time
      t.integer :s1_time
      t.integer :s2_time
      t.integer :s3_time

      t.timestamps
    end
  end
end
