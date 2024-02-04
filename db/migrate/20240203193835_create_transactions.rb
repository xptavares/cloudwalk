class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.datetime :transaction_date
      # t.decimal :transaction_amount, precision: 10, scale: 2
      t.float :transaction_amount
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.integer :device_id, null: true

      t.timestamps
    end
  end
end
