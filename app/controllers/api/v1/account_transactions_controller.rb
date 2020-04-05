class Api::V1::AccountTransactionsController < ActionController::API
  before_action :set_account, only: [:index, :create]
  before_action :set_transaction, except: [:index, :create]

  def index
    query = {
      transaction_type: query_params[:type] || AccountTransaction.transaction_types.values,
      created_at: (query_params[:created_at_from]&.to_date || -Float::INFINITY)..(query_params[:created_at_to]&.to_date || Float::INFINITY),
      amount: (query_params[:amount_from]&.to_f || -Float::INFINITY)..(query_params[:amount_to]&.to_f || Float::INFINITY)
    }

    render json: @account ? @account.account_transactions.where(query).order(created_at: :desc) : AccountTransaction.where(query).order(created_at: :desc), status: 200
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

  def query_params
    params.permit(:account_id, :id, :type, :created_at_from, :created_at_to, :amount_from, :amount_to, :format)
  end
end