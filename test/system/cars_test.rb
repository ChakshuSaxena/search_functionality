require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    fill_in "Drivetrain", with: @car.drivetrain
    fill_in "Exterior color", with: @car.exterior_color
    fill_in "Interior color", with: @car.interior_color
    fill_in "Miles", with: @car.miles
    fill_in "Price", with: @car.price
    fill_in "Stock type", with: @car.stock_type
    fill_in "Title", with: @car.title
    fill_in "Transmission", with: @car.transmission
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    fill_in "Drivetrain", with: @car.drivetrain
    fill_in "Exterior color", with: @car.exterior_color
    fill_in "Interior color", with: @car.interior_color
    fill_in "Miles", with: @car.miles
    fill_in "Price", with: @car.price
    fill_in "Stock type", with: @car.stock_type
    fill_in "Title", with: @car.title
    fill_in "Transmission", with: @car.transmission
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
