require "rails_helper"

RSpec.describe Warehouse, type: :model do
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
    before :each do
      @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
      @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Richmond", state: "VA", country: "USA", postal_code: "38475")
    end

    it "finds warehouses by location" do
      expect(Warehouse.search("Arlington")).to eq([@wh_1])
      expect(Warehouse.search("123 Fake St")).to eq([@wh_1])
      expect(Warehouse.search("USA")).to eq([@wh_1, @wh_2])
      expect(Warehouse.search("Richmond")).to eq([@wh_2])
    end
  end
end
