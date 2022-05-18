require "rails_helper"

RSpec.describe "Items new page" do
  it "creates a new item" do
    visit "/items"
    expect(page).to_not have_content("Straw")

    click_button "Create New Item"

    fill_in :name, with: "Straw"
    fill_in :description, with: "Got liquids to drink but don't love the way your cup tastes? This is for you."
    fill_in :unit_price, with: "5.00"
    click_button "Create Item"

    item = Item.where(name: "Straw").first
    expect(current_path).to eq("/items/#{item.id}")

    visit "/items"
    expect(page).to have_content("Straw")
  end
end
