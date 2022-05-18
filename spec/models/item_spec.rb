require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many(:item_warehouses) }
    it { should have_many(:warehouses).through(:item_warehouses) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "class methods" do
    it "finds items by name" do
      @plate = Item.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)
      @bowl = Item.create!(name: "Bowl", description: "You're not actually gonna serve your chili on a plate are you? You deserve this.", unit_price: 20.00)
      @mug = Item.create!(name: "mug", description: "I know a bunch of people from highschool are making these as a hobby but they do actually have some utility.", unit_price: 25.00)

      expect(Item.search_by_name("plate")).to eq([@plate])
      expect(Item.search_by_name("MuG")).to eq([@mug])
    end
  end
end
