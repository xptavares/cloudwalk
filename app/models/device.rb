class Device < ApplicationRecord
  belongs_to :user

  def self.find_or_create(device_id, user_id)
    Device.where(Device.primary_key => [[device_id, user_id]]).first || Device.create(id: [device_id, user_id], user_id: user_id)
  end
end
