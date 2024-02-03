class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
