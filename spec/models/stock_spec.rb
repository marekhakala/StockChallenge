require 'rails_helper'

RSpec.describe Stock, type: :model do
  context "Validations" do
    it "has a valid name" do
      should validate_presence_of(:name)
    end
  end

  context "Validations" do
    it "has assigned Bearer object" do
      should belong_to(:bearer)
    end

    it "has assigned Marker Price object" do
      should belong_to(:market_price)
    end
  end
end
