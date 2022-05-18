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

  it "flashes errors when form is filled out incorrectly" do
    visit "/items/new"
    # save_and_open_page
    fill_in "Name", with: ""
    fill_in "Description", with: ""
    fill_in "Unit price", with: ""
    click_button "Create Item"

    expect(current_path).to eq("/items/new")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Unit price can't be blank")
  end
end
