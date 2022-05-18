require "rails_helper"

RSpec.describe "Warehouse show page" do
  before :all do
    @wh = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")

    @cup = @wh.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
  end

  before :each do
    visit "/warehouses/#{@wh.id}"
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "lists warehouse full address" do
    expect(page).to have_content(@wh.address)
    expect(page).to have_content(@wh.city)
    expect(page).to have_content(@wh.state)
    expect(page).to have_content(@wh.country)
    expect(page).to have_content(@wh.postal_code)
  end

  it "has link to warehouse index" do
    click_link "All Warehouses"

    expect(current_path).to eq("/warehouses")
  end
end
