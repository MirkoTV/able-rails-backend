class CreatePerformances < ActiveRecord::Migration[6.1]
  def change
    create_table :performances do |t|
      t.references :driver
      t.references :session

      t.integer :best_lap_time
      t.integer :best_s1_time
      t.integer :best_s2_time
      t.integer :best_s3_time
      t.integer :best_potential_time
      t.integer :average_time
      t.boolean :dnf, default: false

      t.timestamps
    end
  end
end
