require 'rails_helper'

RSpec.describe MarketPrice, type: :model do
  context "Validations" do
    it "has a currency code" do
      should validate_presence_of(:currency)
    end

    it "has a currency value in cents" do
      should validate_presence_of(:value_cents)
    end
  end

  context "Associations" do
    it "has many stocks" do
     should have_many(:stocks)
    end
  end
end
