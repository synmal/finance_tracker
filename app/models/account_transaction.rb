class AccountTransaction < ApplicationRecord
  belongs_to :account

  enum transaction_type: [:debit, :credit]

  after_commit :update_account_balance, on: [:create, :update]
  before_update :reset_account_balance, if: :amount_or_type_changed?
  before_destroy :reset_account_balance

  private
  def update_account_balance
    trans_type = debit? ? "-" : "+"
    new_balance = account.balance.send(trans_type, amount)
    account.update(balance: new_balance)
  end

  def reset_account_balance
    trans_type = transaction_type_change&.first || transaction_type
    old_amount = amount_change&.first || amount

    operation = trans_type == "debit" ? "+" : "-"
    new_balance = account.balance.send(operation, old_amount)
    account.update(balance: new_balance)
  end

  def amount_or_type_changed?
    amount_changed? || transaction_type_changed?
  end
end