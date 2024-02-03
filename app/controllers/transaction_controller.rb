class TransactionController < ApplicationController
  def create
    json = Transaction::CreateService.new(transaction_params).perform
    render json: json, status: 200
  end

  private
    def transaction_params
      params.permit(:transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id)
    end
end
