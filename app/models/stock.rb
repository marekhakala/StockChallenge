class Stock < ApplicationRecord
  acts_as_paranoid

  belongs_to :bearer
  belongs_to :market_price

  validates :name, presence: true

  attr_accessor :bearer_name, :value_cents, :currency
  before_validation :set_bearer, :set_market_price

  protected
  def set_bearer
    self.bearer = Bearer.where(name: self.bearer_name).first_or_create if self.bearer_name
  end

  def set_market_price
    self.currency = self.try(:market_price).try(:currency) if self.currency.nil?

    if self.value_cents and self.currency
      searchMarketPrice = MarketPrice.where(value_cents: self.value_cents, currency: self.currency)
      self.market_price = searchMarketPrice.first_or_create
    end
  end
end
