class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.float :amount
      t.string :transaction_type
      t.string :transaction_note

      t.timestamps
    end
  end
end
