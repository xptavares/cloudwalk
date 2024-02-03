class Transaction::HashToModelService

  attr_accessor :hash

  def initialize(hash)
    @hash = hash
  end
  

  def perform
    transaction_id = hash["transaction_id"]
    merchant_id = hash["merchant_id"]
    user_id = hash["user_id"]
    card_number = hash["card_number"]
    transaction_date = hash["transaction_date"]
    transaction_amount = hash["transaction_amount"]
    device_id = hash["device_id"]
    has_cbk = hash["has_cbk"]

    user = User.where(id: user_id).first_or_create
    merchant = Merchant.where(id: merchant_id).first_or_create
    card = Card.where(card_number: card_number, user_id: user_id).first_or_create
    if device_id
      device = Device.find_or_create(device_id, user_id)
    end
    transaction = Transaction.create!(id: transaction_id, merchant: merchant, user: user, card: card, transaction_date: transaction_date, transaction_amount: transaction_amount, device_id: device_id)
    
    user.update!(has_cbk: true) if has_cbk == "TRUE"
  end
end
