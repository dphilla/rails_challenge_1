require "rails_helper"

feature "visitor views multiple machines" do
  before(:each) do
    @vending_machine_1 = Machine.create(location: "Don's Mixed Drinks")
    @vending_machine_2 = Machine.create(location: "Turing School")

    @white_castle_burger = Snack.create(name: "White Castle Burger", price: 3.78)
    @pop_rocks = Snack.create(name: "Pop Rocks", price: 1.87)
    @flaming_hot_cheetos = Snack.create(name: "Flaming Hot Cheetos", price: 2.53)
  end
  scenario "visitor sees two machines with same items" do

    visit machine_snacks_path(@vending_machine_1)

    expect(page).to have_content(@vending_machine_1.location)
    expect(page).to have_content("Choose Items for My Machine:")

    expect(page).to have_content(@white_castle_burger.name)
    expect(page).to have_content(@pop_rocks.name)
    expect(page).to have_content(@flaming_hot_cheetos.name)
  end
end
