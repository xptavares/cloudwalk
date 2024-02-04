require 'rails_helper'

RSpec.describe Transaction::UpdateScoreService do

  let(:device_id) { 111 }
  let(:user_id) { 555 }
  let(:service) {  Transaction::UpdateScoreService.new(user_id) }
  let!(:user) { User.where(id: user_id).first_or_create }

  describe "if user are sharing device" do
    before :each do
      other_user = User.where(id: 333).first_or_create
      device = Device.find_or_create(device_id, user.id)
      other_device = Device.find_or_create(device_id, other_user.id)
    end

    it "should update to B" do
      expect(service.perform).to eq(true)

      user.reload

      expect(user.B?).to eq(true)
    end

    describe "with three diveces" do
      before :each do
        other_user = User.where(id: 333).first_or_create
        other_three_user = User.where(id: 222).first_or_create
        Device.find_or_create(device_id, user.id)
        Device.find_or_create(device_id, other_user.id)
        Device.find_or_create(device_id, other_three_user.id)
      end

      it "should update to C" do
        expect(service.perform).to eq(true)
  
        user.reload
  
        expect(user.C?).to eq(true)
      end
    end

    describe "with five diveces" do
      before :each do
        other_user = User.where(id: 333).first_or_create
        other_three_user = User.where(id: 222).first_or_create
        other_four_user = User.where(id: 111).first_or_create
        other_five_user = User.where(id: 444).first_or_create
        other_six_user = User.where(id: 777).first_or_create
        other_seven_user = User.where(id: 666).first_or_create
        Device.find_or_create(device_id, user.id)
        Device.find_or_create(device_id, other_user.id)
        Device.find_or_create(device_id, other_three_user.id)
        Device.find_or_create(device_id, other_four_user.id)
        Device.find_or_create(device_id, other_five_user.id)
        Device.find_or_create(device_id, other_six_user.id)
        Device.find_or_create(device_id, other_seven_user.id)
      end

      it "should update to E" do
        expect(service.perform).to eq(true)
  
        user.reload
  
        expect(user.E?).to eq(true)
      end
    end
    
  end
end
