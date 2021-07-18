class Donations::Subscription < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(active: true) }

  def amount_in_dollars
    amount_in_cents / 100.0
  end
end