class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :merchant
  belongs_to :device, optional: true
  belongs_to :card
end
