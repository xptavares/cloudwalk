require 'rails_helper'

RSpec.describe Transaction::ValidateScoreService do

  let(:user_id) { 555 }
  let(:service) {  Transaction::ValidateScoreService.new(user_id) }
  let!(:user) { User.where(id: user_id).first_or_create }

  describe "with A" do
    it { expect(service.perform).to eq(true)  }
  end

  describe "with B" do
    before :each do
      user.B!
    end
    it { expect(service.perform).to eq(true)  }
  end

  describe "with C" do
    before :each do
      user.C!
    end
    it { expect(service.perform).to eq(false)  }
  end

  describe "with D" do
    before :each do
      user.D!
    end
    it { expect(service.perform).to eq(false)  }
  end

  describe "with E" do
    before :each do
      user.E!
    end
    it { expect(service.perform).to eq(false)  }
  end
end
