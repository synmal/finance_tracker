# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create accounts
3.times do
  account_details = {
    name: Faker::Bank.name,
    balance: Faker::Number.decimal(l_digits: 3)
  }
  Account.create!(account_details)
end

# Create transactions
Account.all.each do |acc|
  3.times{acc.account_transactions.create!(amount: Faker::Number.within(range: 1..50), transaction_type: 0)}
end