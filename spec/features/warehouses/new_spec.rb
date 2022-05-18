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
end
