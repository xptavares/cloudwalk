require 'rails_helper'

RSpec.describe Transaction::HashToModelService do
  let(:hash) { {"transaction_id"=>"21323596", "merchant_id"=>"17348", "user_id"=>"8", "card_number"=>"650487******9884", "transaction_date"=>"2019-11-01T01:27:15.811098", "transaction_amount"=>"2416.70", "device_id"=>nil, "has_cbk"=>"FALSE"} }
  let(:service) {  Transaction::HashToModelService.new(hash) }

  describe "without device id" do
    it "expect to not create device" do
      service.perform
      expect(Device.count).to eq(0) 
    end
  end

  describe "with device id" do
    let(:hash) { {"transaction_id"=>"21323596", "merchant_id"=>"17348", "user_id"=>"8", "card_number"=>"650487******9884", "transaction_date"=>"2019-11-01T01:27:15.811098", "transaction_amount"=>"2416.70", "device_id"=>"10000", "has_cbk"=>"FALSE"} }
    it "expect to create device" do
      service.perform
      expect(Device.count).to eq(1) 
    end
  end

  describe "with has_cbk false" do
    it "expect has_cbk to be false" do
      service.perform
      expect(User.find(hash["user_id"]).has_cbk).to eq(false) 
    end
  end

  describe "with has_cbk true" do
    let(:hash) { {"transaction_id"=>"21323596", "merchant_id"=>"17348", "user_id"=>"8", "card_number"=>"650487******9884", "transaction_date"=>"2019-11-01T01:27:15.811098", "transaction_amount"=>"2416.70", "device_id"=>"10000", "has_cbk"=>"TRUE"} }
    it "expect has_cbk to be true" do
      service.perform
      expect(User.find(hash["user_id"]).has_cbk).to eq(true) 
    end
  end
end
