require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Email validation for Update" do
    visit edit_company_path(@company)

    initial_name = @company.name
    initial_zip_code = @company.zip_code
    initial_email = @company.email

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: "new_test_company@abcd.com")
      click_button "Update Company"
    end

    @company.reload
    assert_equal initial_name, @company.name
    assert_equal initial_zip_code, @company.zip_code
    assert_equal initial_email, @company.email
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Email validation for Create" do
    visit new_company_path

    last_company1 = Company.last
    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@abcd.com")
      click_button "Create Company"
    end

    last_company2 = Company.last
    assert_equal last_company1.name, last_company2.name
    assert_equal last_company1.zip_code, last_company2.zip_code
    assert_equal last_company1.email, last_company2.email
  end

  test "Delete" do
    visit company_path(@company)

    accept_confirm do
      click_link "Delete"
    end

    assert_text "Company Deleted"

  end

end
