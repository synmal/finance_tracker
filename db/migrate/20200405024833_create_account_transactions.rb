class CreateAccountTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :account_transactions do |t|
      t.belongs_to :account
      t.decimal :amount, null: false
      t.timestamps
    end
  end
end
