require "rails_helper"

RSpec.describe "Warehouse index page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
    @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Richmond", state: "VA", country: "USA", postal_code: "38475")
  end

  before :each do
    visit warehouses_path
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "searches for warehouses by location" do
    expect(page).to have_content("Richmond")
    expect(page).to have_content("Arlington")

    fill_in :search, with: "arlington"
    click_button "Search"

    expect(current_path).to eq(warehouses_path)
    expect(page).to_not have_content("Richmond")
    expect(page).to have_content("Arlington")
  end

  it "links to warehouse show page" do
    within("##{@wh_1.id}") do
      click_button "View This Warehouse"
    end

    expect(current_path).to eq("/warehouses/#{@wh_1.id}")
  end

  it "has button to create new warehouse" do
    click_button "Create New Warehouse"

    expect(current_path).to eq("/warehouses/new")
  end
end
