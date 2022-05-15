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
end
