require "rails_helper"

RSpec.describe "Warehouses new page" do
  it "creates a new warehouse" do
    visit "/warehouses"
    expect(page).to_not have_content("Arlington")

    click_button "Create New Warehouse"

    fill_in :address, with: "123 Fake St"
    fill_in :city, with: "Arlington"
    fill_in :state, with: "VA"
    fill_in :country, with: "USA"
    fill_in :postal_code, with: "29846"
    click_button "Create Warehouse"

    wh = Warehouse.where(city: "Arlington").first
    expect(current_path).to eq("/warehouses/#{wh.id}")

    visit "/warehouses"
    expect(page).to have_content("Arlington")
  end

  it "flashes errors when form is filled out incorrectly" do
    visit "/warehouses/new"
  
    fill_in "Address", with: ""
    fill_in "City", with: ""
    fill_in "State", with: ""
    fill_in "Country", with: ""
    fill_in "Postal code", with: ""
    click_button "Create Warehouse"

    expect(current_path).to eq("/warehouses/new")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Country can't be blank")
    expect(page).to have_content("Postal code can't be blank")
  end
end
