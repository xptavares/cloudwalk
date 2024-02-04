require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:params) do
    {
      transaction_id: 2342357,
      merchant_id: 29744,
      user_id: 97051,
      card_number: "434505******9116",
      transaction_date: Time.zone.now,
      transaction_amount: 999,
      device_id: 285475
    }
  end

  describe "POST /" do
    it "returns http success" do
      post "/api/transactions", params: params
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:transaction_id]).to  eq('2342357')
      expect(json[:recommendation]).to  eq('approve')
    end

    it "should disapprove with no limit" do
      post "/api/transactions", params: params
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:transaction_id]).to  eq('2342357')
      expect(json[:recommendation]).to  eq('approve')

      params["transaction_id"] = 2342358
      params["transaction_date"] = Time.zone.now

      post "/api/transactions", params: params
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:transaction_id]).to  eq('2342358')
      expect(json[:recommendation]).to  eq('disapprove')
    end

    it "should disapprove without device_id" do
      params.delete(:device_id)
      post "/api/transactions", params: params
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:transaction_id]).to  eq('2342357')
      expect(json[:recommendation]).to  eq('disapprove')
    end
  end
end
