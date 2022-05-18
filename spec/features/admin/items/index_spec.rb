require "rails_helper"

RSpec.describe "Admin items index page" do
  before :all do
    @wh_1 = Warehouse.create!(address: "123 Fake St", city: "Arlington", state: "VA", country: "USA", postal_code: "50890")
    @wh_2 = Warehouse.create!(address: "987 Circles Ave", city: "Fresno", state: "CA", country: "USA", postal_code: "38475")

    @cup = @wh_1.items.create!(name: "Cup", description: "Have liquids? Want to consume them? BOY will this help you out.", unit_price: 10.00)
    @plate = @wh_1.items.create!(name: "Plate", description: "Let me know how you're going to serve that quinoa burrito without this thing.", unit_price: 15.00)
    @bowl = @wh_2.items.create!(name: "Bowl", description: "You're not actually gonna serve your chili on a plate are you? You deserve this.", unit_price: 20.00)
    @mug = @wh_2.items.create!(name: "Mug", description: "I know a bunch of people from highschool are making these as a hobby but they do actually have some utility.", unit_price: 25.00)
  end

  before :each do
    visit "/admin/items?id=#{@wh_1.id}"
  end

  after :all do
    ItemWarehouse.destroy_all
    Item.destroy_all
    Warehouse.destroy_all
  end

  it "has button to add item to warehouse inventory" do
    within("##{@cup.id}") do
      click_button "Add Item to Warehouse at #{@wh_1.address}, #{@wh_1.city}, #{@wh_1.state}"
    end
  end
end
