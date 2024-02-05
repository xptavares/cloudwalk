class TransactionController < ApplicationController
  def create
    # here we can add it to redis.
    protect_request(transaction_params["user_id"]) do
      # also here we can use a sidekiq job.
      json = Transaction::CreateService.new(transaction_params).perform
      render json: json, status: 200
    end
  end

  private
    def transaction_params
      params.permit(:transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id)
    end
end
