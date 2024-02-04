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
    return { transaction_id: transaction_id, recommendation: 'disapprove' } unless validations

    transaction = Transaction.new(id: transaction_id, merchant: merchant, user: user, card: card, transaction_date: transaction_date, transaction_amount: transaction_amount, device_id: device_id)
    return { transaction_id: transaction_id, recommendation: 'disapprove' } unless transaction.valid?

    transaction.save

    { transaction_id: transaction.id.to_s, recommendation: 'approve' }
  end

  private
    def validations
      return false unless Transaction::ValidateAmountService.new(user_id, transaction_date, transaction_amount).perform
      return false unless Transaction::ValidateChargebackService.new(user_id).perform
      return false unless Transaction::ValidateScoreService.new(user_id).perform
      return false unless device_id
      true
    end

    def user
      @user ||= User.where(id: user_id).first_or_create
    end

    def merchant
      @merchant ||= Merchant.where(id: merchant_id).first_or_create
    end

    def card
      @card ||= Card.where(card_number: card_number, user_id: user_id).first_or_create
    end
    
  
end
