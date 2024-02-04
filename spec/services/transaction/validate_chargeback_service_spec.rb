require 'rails_helper'

RSpec.describe Transaction::ValidateChargebackService do

  let(:user_id) { 555 }
  let(:service) {  Transaction::ValidateChargebackService.new(user_id) }
  let(:user) { User.where(id: user_id).first_or_create }

  describe "with no chargeback" do
    it { expect(service.perform).to eq(true)  }
  end

  describe "with chargeback" do
    before :each do
      user.has_cbk = true
      user.save
    end
    it { expect(service.perform).to eq(false)  }
  end
end
