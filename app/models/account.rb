class Account < ApplicationRecord
  has_many :account_transactions
  validates :name, presence: true

  class << self
    def total_balance
      all.pluck(:balance).sum
    end
  end

  def transactions
    self.transactions
  end

  def total_transactions
    self.transactions.pluck(:amount).sum
  end
end
