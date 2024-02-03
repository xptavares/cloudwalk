class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices, primary_key: %i[id user_id] do |t|
      t.integer :id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
