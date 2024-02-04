require 'rails_helper'

RSpec.describe Transaction::ValidateAmountService do
  let(:user_id) { 555 }
  let(:transaction_date) { Time.zone.now }
  let(:transaction_amount) { 100.00 }
  let(:service) {  Transaction::ValidateAmountService.new(user_id, transaction_date, transaction_amount) }

  describe "with no more limit" do
    it "expect to return false" do
      expect(service.perform).to eq(false) 
    end
  end
end
