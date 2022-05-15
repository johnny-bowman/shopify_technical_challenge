require "rails_helper"

RSpec.describe "Items show page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 1000)
  end

  before :each do
    visit "/items/#{@cup.id}"
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "lists item name, description, and unit price" do
    expect(page).to have_content(@cup.name)
    expect(page).to have_content(@cup.description)
    expect(page).to have_content(@cup.unit_price)
  end
end
