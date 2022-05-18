require "rails_helper"

RSpec.describe "Welcome Index" do
  it "links to warehouse and item index" do
    visit root_path
    click_button "Warehouses"
    expect(current_path).to eq("/warehouses")

    visit root_path
    click_button "Items"
    expect(current_path).to eq("/items")
  end
end
