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
end
