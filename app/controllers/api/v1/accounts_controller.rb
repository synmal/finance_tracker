class Api::V1::AccountsController < ActionController::API
  before_action :set_account, only: [:show, :destroy, :update]
  
  def index
    render json: {
      accounts: Account.all,
      total_balance: Account.total_balance
    }, status: 200
  end

  def show
    render json: @account, status: 200
  end

  def create
    account = Account.create!(account_params)
    render json: account, status: 200
  rescue => e
    render json: {error: e.message}, status: 400
  end

  def update
    @account.update!(account_params)
    render json: @account, status: 200
  rescue => e
    render json: {error: e.message}, status: 400
  end

  def destroy
    @account.destroy
    render json: {notice: "Account successfully deleted"}
  rescue => e
    render json: {error: e.message}, status: 500
  end

  private
  def set_account
    @account = Account.find(params[:id])
  rescue => e
    render json: {error: e}, status: 404
  end

  def account_params
    params.require(:account).permit(:name, :balance)
  end
end