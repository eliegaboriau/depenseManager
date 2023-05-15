require "application_system_test_case"

class DepensesTest < ApplicationSystemTestCase
  setup do
    @depense = depenses(:one)
  end

  test "visiting the index" do
    visit depenses_url
    assert_selector "h1", text: "Depenses"
  end

  test "creating a Depense" do
    visit depenses_url
    click_on "New Depense"

    fill_in "Amount", with: @depense.amount
    fill_in "Category", with: @depense.category_id
    fill_in "Date", with: @depense.date
    fill_in "User", with: @depense.user_id
    click_on "Create Depense"

    assert_text "Depense was successfully created"
    click_on "Back"
  end

  test "updating a Depense" do
    visit depenses_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @depense.amount
    fill_in "Category", with: @depense.category_id
    fill_in "Date", with: @depense.date
    fill_in "User", with: @depense.user_id
    click_on "Update Depense"

    assert_text "Depense was successfully updated"
    click_on "Back"
  end

  test "destroying a Depense" do
    visit depenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Depense was successfully destroyed"
  end
end
