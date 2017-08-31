require 'rails_helper'

RSpec.describe Bearer, type: :model do
  context "Validations" do
    it "has a valid name" do
      should validate_presence_of(:name)
    end

    it "has a unique name" do
      should validate_uniqueness_of(:name)
    end
  end

  context "Associations" do
    it "has many stocks" do
      should have_many(:stocks)
    end
  end
end
