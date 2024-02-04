require 'rails_helper'

RSpec.describe Transaction::ValidateScoreService do

  let(:user_id) { 555 }
  let(:service) {  Transaction::ValidateScoreService.new(user_id) }
  let!(:user) { User.where(id: user_id).first_or_create }

  describe "with A" do
    it { expect(service.perform).to eq(true)  }
  end

  describe "with C" do
    before :each do
      user.C!
    end
    it { expect(service.perform).to eq(false)  }
  end
end
