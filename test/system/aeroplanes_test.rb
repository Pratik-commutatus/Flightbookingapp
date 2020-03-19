require "application_system_test_case"

class AeroplanesTest < ApplicationSystemTestCase
  setup do
    @aeroplane = aeroplanes(:one)
  end

  test "visiting the index" do
    visit aeroplanes_url
    assert_selector "h1", text: "Aeroplanes"
  end

  test "creating a Aeroplane" do
    visit aeroplanes_url
    click_on "New Aeroplane"

    fill_in "Model", with: @aeroplane.model
    fill_in "Number of seats", with: @aeroplane.number_of_seats
    click_on "Create Aeroplane"

    assert_text "Aeroplane was successfully created"
    click_on "Back"
  end

  test "updating a Aeroplane" do
    visit aeroplanes_url
    click_on "Edit", match: :first

    fill_in "Model", with: @aeroplane.model
    fill_in "Number of seats", with: @aeroplane.number_of_seats
    click_on "Update Aeroplane"

    assert_text "Aeroplane was successfully updated"
    click_on "Back"
  end

  test "destroying a Aeroplane" do
    visit aeroplanes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Aeroplane was successfully destroyed"
  end
end
