require "rails_helper"

RSpec.describe "Warehouse show page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
    @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Richmond", state: "VA", country: "USA", postal_code: "38475")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
    @plate = @wh_1.items.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)
    @bowl = @wh_2.items.create!(name: "Bowl", description: "You're not actually gonna serve your chili on a plate are you? You deserve this.", unit_price: 20.00)
  end

  before :each do
    visit "/warehouses/#{@wh_1.id}"
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "lists warehouse full address" do
    expect(page).to have_content(@wh_1.address)
    expect(page).to have_content(@wh_1.city)
    expect(page).to have_content(@wh_1.state)
    expect(page).to have_content(@wh_1.country)
    expect(page).to have_content(@wh_1.postal_code)
  end

  it "has link to warehouse index" do
    click_link "All Warehouses"

    expect(current_path).to eq("/warehouses")
  end

  it "has button to delete warehouse" do
    visit "/warehouses"
    expect(page).to have_content("#{@wh_1.address}")

    visit "/warehouses/#{@wh_1.id}"
    click_button "Delete Warehouse"

    expect(current_path).to eq("/warehouses")
    expect(page).to_not have_content("#{@wh_1.address}")
  end

  it "displays warehouse inventory" do
    expect(page).to have_content(@cup.name)
    expect(page).to have_content(@plate.name)
    expect(page).to_not have_content(@bowl.name)
  end
end
