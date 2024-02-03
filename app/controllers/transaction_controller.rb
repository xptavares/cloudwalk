class TransactionController < ApplicationController
  def create
    render json: { transaction_id: '2342357', recommendation: 'approve' }, status: 200
  end
end
