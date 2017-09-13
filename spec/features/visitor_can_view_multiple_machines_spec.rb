require "rails_helper"

feature "visitor views multiple machines" do
  
  before(:each) do
    @vending_machine_1 = Machine.create(location: "Don's Mixed Drinks")
    @vending_machine_2 = Machine.create(location: "Turing School")

    @white_castle_burger = Snack.create(name: "White Castle Burger", price: 3.78)
    @pop_rocks = Snack.create(name: "Pop Rocks", price: 1.87)
    @flaming_hot_cheetos = Snack.create(name: "Flaming Hot Cheetos", price: 2.53)
  end

  scenario "visitor see a list of vending machines" do
    visit machines_path

    expect(page).to have_content(@vending_machine_1.location)
    expect(page).to have_content(@vending_machine_2.location)
    expect(page).to have_css(:ul, count: 2)
    expect(page).to have_button("Add Snacks to This Vending Machine")
  end

  scenario "visitor can see snacks options to add to machine" do

    visit machines_path

    within("ul", match: :first) do
      click_on "Add Snacks to This Vending Machine"
    end

    expect(current_path).to eq(machine_snacks_path(@vending_machine_1))

    expect(page).to have_content(@white_castle_burger.name)
    expect(page).to have_content(@pop_rocks.name)
    expect(page).to have_content(@flaming_hot_cheetos.name)
    expect(page).to have_button("Add This Snack to My Machine")
  end

  scenario "visitor add snacks to one machine" do
    visit machine_snacks_path(@vending_machine_1)

    within("ul", match: :first) do
      click_on "Add This Snack to My Machine"
    end

    expect(current_path).to eq(machine_path(@vending_machine_1))
    expect(page).to have_content(@white_castle_burger.name)
    expect(page).to have_content(@white_castle_burger.price)
    expect(page).to have_button("Add More Snacks to This Machine")
  end

  scenario "visitor can add same snack to another machine" do

    visit machine_snacks_path(@vending_machine_1)

    within("ul", match: :first) do
      click_on "Add This Snack to My Machine"
    end

    expect(current_path).to eq(machine_path(@vending_machine_1))
    expect(page).to have_content(@white_castle_burger.name)
    expect(page).to have_content(@white_castle_burger.price)
    expect(page).to have_button("Add More Snacks to This Machine")

    visit machine_snacks_path(@vending_machine_2)

    within("ul", match: :first) do
      click_on "Add This Snack to My Machine"
    end

    expect(current_path).to eq(machine_path(@vending_machine_2))
    expect(page).to have_content(@white_castle_burger.name)
    expect(page).to have_content(@white_castle_burger.price)
    expect(page).to have_button("Add More Snacks to This Machine")
  end
end
