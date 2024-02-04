require 'rails_helper'

RSpec.describe Transaction::ValidateAmountService do
  let(:card_number) { '527496******2850' }
  let(:transaction_id) { 555 }
  let(:merchant_id) { 555 }
  let(:device_id) { 555 }
  let(:user_id) { 555 }
  let(:transaction_date) { Time.zone.now }
  let(:transaction_amount) { 999.00 }
  let(:service) {  Transaction::ValidateAmountService.new(user_id, transaction_date, transaction_amount) }

  describe "with no more limit" do
    before :each do
      user = User.where(id: user_id).first_or_create
      merchant = Merchant.where(id: merchant_id).first_or_create
      card = Card.where(card_number: card_number, user_id: user_id).first_or_create
      device = Device.find_or_create(device_id, user_id)
      transaction = Transaction.create!(id: transaction_id, merchant: merchant, user: user, card: card, transaction_date: 1.minute.ago, transaction_amount: 50.00, device_id: device_id)
    end

    it { expect(service.perform).to eq(false)  }
  end

  describe "with limit" do
    it { expect(service.perform).to eq(true)  }
  end

  describe "with valid period" do
    before :each do
      user = User.where(id: user_id).first_or_create
      merchant = Merchant.where(id: merchant_id).first_or_create
      card = Card.where(card_number: card_number, user_id: user_id).first_or_create
      device = Device.find_or_create(device_id, user_id)
      transaction = Transaction.create!(id: transaction_id, merchant: merchant, user: user, card: card, transaction_date: 2.days.ago, transaction_amount: 50.00, device_id: device_id)
    end
    it { expect(service.perform).to eq(true)  }
  end

  describe "chaging the period" do
    before :each do
      user = User.where(id: user_id).first_or_create
      merchant = Merchant.where(id: merchant_id).first_or_create
      card = Card.where(card_number: card_number, user_id: user_id).first_or_create
      device = Device.find_or_create(device_id, user_id)
      transaction = Transaction.create!(id: transaction_id, merchant: merchant, user: user, card: card, transaction_date: 2.days.ago, transaction_amount: 50.00, device_id: device_id)
    end

    let(:service) {  Transaction::ValidateAmountService.new(user_id, transaction_date, transaction_amount, 3.days.ago) }

    it { expect(service.perform).to eq(false)  }
  end
end
