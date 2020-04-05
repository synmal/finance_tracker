class ChangeBalanceToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :balance, :decimal
  end
end
