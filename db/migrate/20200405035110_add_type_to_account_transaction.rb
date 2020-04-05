class AddTypeToAccountTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :account_transactions, :transaction_type, :integer, null: false
  end
end
