require "rails_helper"

RSpec.describe "Admin items index page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
    @plate = @wh_1.items.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)
    @mug = Item.create!(name: "Mug", description: "I know a bunch of people from highschool are making these as a hobby but they do actually have some utility.", unit_price: 25.00)
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "has button to add item to warehouse inventory" do
    visit "/warehouses/#{@wh_1.id}"
    expect(page).to_not have_content(@mug.name)

    visit "/admin/items?id=#{@wh_1.id}"
    within("##{@mug.id}") do
      fill_in :quantity, with: "4"
      click_button "Add to Warehouse at #{@wh_1.address}, #{@wh_1.city}, #{@wh_1.state}"
    end
    
    expect(current_path).to eq("/warehouses/#{@wh_1.id}")
    expect(page).to have_content(@mug.name)
    expect(page).to have_content("Quantity in Stock: 4")
  end
end
