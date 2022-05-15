require "rails_helper"

RSpec.describe "Item edit page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.05)
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "updates item info" do
    visit "/items/#{@cup.id}"
    
    expect(page).to have_content(@cup.name)
    expect(page).to have_content(@cup.description)
    expect(page).to have_content("$10.05")

    expect(page).to_not have_content("Straw")
    expect(page).to_not have_content("Got liquids to drink but don't love the way your cup tastes? This is for you.")
    expect(page).to_not have_content("$5.00")

    click_link("Edit Item")

    fill_in "Name:", with: "Straw"
    fill_in "Description:", with: "Got liquids to drink but don't love the way your cup tastes? This is for you."
    fill_in "Unit Price:", with: "5.00"
    click_button "Update Item"

    expect(current_path).to eq("/items/#{@cup.id}")
  end
end
