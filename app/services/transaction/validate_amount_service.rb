class Transaction::ValidateAmountService

  attr_accessor :user_id, :transaction_date, :transaction_amount

  def initialize(user_id, transaction_date, transaction_amount)
    @user_id = user_id
    @transaction_date = transaction_date
    @transaction_amount = transaction_amount
  end

  def perform
    Transaction.where("created_at >= ?", 1.day.ago).where(user_id: user_id).sum(:transaction_amount)
    true
  end
end
