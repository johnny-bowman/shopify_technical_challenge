require "rails_helper"

RSpec.describe "Items index page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
    @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Fresno", state: "CA", country: "USA", postal_code: "38475")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
    @plate = @wh_1.items.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)
    @bowl = @wh_2.items.create!(name: "Bowl", description: "You're not actually gonna serve your chili on a plate are you? You deserve this.", unit_price: 20.00)
    @mug = @wh_2.items.create!(name: "Mug", description: "I know a bunch of people from highschool are making these as a hobby but they do actually have some utility.", unit_price: 25.00)
  end

  before :each do
    visit items_path
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "lists all items alphabetically" do
    expect(@bowl.name).to appear_before(@cup.name)
    expect(@cup.name).to appear_before(@mug.name)
    expect(@mug.name).to appear_before(@plate.name)
  end

  it "searches for items by name" do
    expect(page).to have_content("Bowl")
    expect(page).to have_content("Cup")
    expect(page).to have_content("Mug")
    expect(page).to have_content("Plate")

    fill_in :search, with: "plATe"
    click_button "Search"

    expect(current_path).to eq(items_path)
    expect(page).to_not have_content("Bowl")
    expect(page).to_not have_content("Cup")
    expect(page).to_not have_content("Mug")
    expect(page).to have_content("Plate")
  end

  it "links to item show pages" do
    within("##{@bowl.id}") do
      click_link "#{@bowl.name}"
    end

    expect(current_path).to eq("/items/#{@bowl.id}")
  end

  it "has button to create new item" do
    click_button "Create New Item"

    expect(current_path).to eq("/items/new")
  end
end
