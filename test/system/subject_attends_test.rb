require "application_system_test_case"

class SubjectAttendsTest < ApplicationSystemTestCase
  setup do
    @subject_attend = subject_attends(:one)
  end

  test "visiting the index" do
    visit subject_attends_url
    assert_selector "h1", text: "Subject Attends"
  end

  test "creating a Subject attend" do
    visit subject_attends_url
    click_on "New Subject Attend"

    fill_in "Subject", with: @subject_attend.subject_id
    fill_in "User", with: @subject_attend.user_id
    click_on "Create Subject attend"

    assert_text "Subject attend was successfully created"
    click_on "Back"
  end

  test "updating a Subject attend" do
    visit subject_attends_url
    click_on "Edit", match: :first

    fill_in "Subject", with: @subject_attend.subject_id
    fill_in "User", with: @subject_attend.user_id
    click_on "Update Subject attend"

    assert_text "Subject attend was successfully updated"
    click_on "Back"
  end

  test "destroying a Subject attend" do
    visit subject_attends_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subject attend was successfully destroyed"
  end
end
