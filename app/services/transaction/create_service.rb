class Transaction::CreateService

  attr_accessor :transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id

  def initialize(params)
    @transaction_id = params["transaction_id"]
    @merchant_id = params["merchant_id"]
    @user_id = params["user_id"]
    @card_number = params["card_number"]
    @transaction_date = params["transaction_date"]
    @transaction_amount = params["transaction_amount"]
    @device_id = params["device_id"]
  end
  

  def perform
    # sleep(1000.0/24.0)
    { transaction_id: '2342357', recommendation: 'approve' }
  end

  private
  def validations
    Transaction::ValidateAmountService.new(user_id, transaction_date, transaction_amount).perform
  end
  
end
