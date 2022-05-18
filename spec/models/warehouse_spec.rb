require "rails_helper"

RSpec.describe Warehouse, type: :model do
  before :each do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
    @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Richmond", state: "VA", country: "USA", postal_code: "38475")
  end

  describe "relationships" do
    it { should have_many(:item_warehouses) }
    it { should have_many(:items).through(:item_warehouses) }
  end

  describe "validations" do
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :country }
    it { should validate_presence_of :postal_code }
  end

  describe "class methods" do
    it "finds warehouses by location" do
      expect(Warehouse.search_by_location("arlington")).to eq([@wh_1])
      expect(Warehouse.search_by_location("123 fAke st")).to eq([@wh_1])
      expect(Warehouse.search_by_location("uSA")).to eq([@wh_1, @wh_2])
      expect(Warehouse.search_by_location("Richmond")).to eq([@wh_2])
    end
  end

  describe "instance methods" do
    it "returns quantity of items in inventory" do
      @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
      @plate = @wh_1.items.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)

      ItemWarehouse.create!(item_id: @cup.id, warehouse_id: @wh_1.id)
      ItemWarehouse.create!(item_id: @plate.id, warehouse_id: @wh_1.id)
      ItemWarehouse.create!(item_id: @plate.id, warehouse_id: @wh_1.id)

      expect(@wh_1.item_quantity(@cup.id)).to eq(2)
      expect(@wh_1.item_quantity(@plate.id)).to eq(3)
    end
  end
end
