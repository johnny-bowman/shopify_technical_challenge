require "rails_helper"

RSpec.describe "Item show page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
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
    expect(page).to have_content("$10.00")
  end

  it "has link to edit item" do
    click_button "Edit Item"

    expect(current_path).to eq("/items/#{@cup.id}/edit")
  end

  it "has link to item index" do
    click_link "All Items"

    expect(current_path).to eq("/items")
  end

  it "has button to delete item" do
    visit "/items"
    expect(page).to have_content("#{@cup.description}")

    visit "/items/#{@cup.id}"
    click_button "Delete Item"

    expect(current_path).to eq("/items")
    expect(page).to_not have_content("#{@cup.description}")
  end
end
