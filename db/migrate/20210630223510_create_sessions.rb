class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :name
      t.datetime :active_at

      t.timestamps
    end
  end
end
