class Transaction::ValidateAmountService

  attr_accessor :user_id, :transaction_date, :transaction_amount, :period

  MAX_VALUE = 100

  def initialize(user_id, transaction_date, transaction_amount, period = 1.day.ago)
    @user_id = user_id
    @transaction_date = transaction_date
    @transaction_amount = transaction_amount
    @period = period
  end

  def perform
    return false if validate
    true
  end

  private
    def sum
      @sum ||= Transaction.where("transaction_date >= ?", period).where(user_id: user_id).sum(:transaction_amount)
    end

    def total
      sum + transaction_amount
    end

    def validate
      total > MAX_VALUE 
    end
end
