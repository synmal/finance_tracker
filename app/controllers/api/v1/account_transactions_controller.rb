class Api::V1::AccountTransactionsController < ActionController::API
  before_action :set_account, only: [:index, :create]
  before_action :set_transaction, except: [:index, :create]

  def index
    params[:type] ||= "all"

    unless ["all", "debit", "credit"].include?(params[:type])
      raise NoMethodError, "Type params only accept 'all', 'debit' or 'credit'"
    end

    if @account
      render json: @account.account_transactions.send(params[:type]), status: 200
    else
      render json: AccountTransaction.send(params[:type]), status: 200
    end

  rescue NoMethodError => e
    render json: {error: e}, status: 400
  rescue => e
    render json: {error: e}, status: 500
  end

  def show
    render json: @transaction, status: 200
  end

  def create
    render json: @account.account_transactions.create!(transaction_params), status: 201
  rescue => e
    render json: {error: e}, status: 400
  end

  def update
    @transaction.update!(transaction_params)
    render json: @transaction, status: 200
  rescue => e
    render json: {error: e}, status: 400
  end

  def destroy
    @transaction.destroy!
    render json: {notice: "Successfully deleting transaction"}, status: 200
  rescue => e
    render json: {error: e}, status: 500
  end

  private
  def set_account
    @account = Account.find_by_id(params[:account_id])
  rescue => e
    render json: {error: e}, status: 404
  end

  def set_transaction
    @transaction = AccountTransaction.find(params[:id])
  rescue => e
    render json: {error: e}, status: 404
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type)
  end
end