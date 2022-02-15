require "application_system_test_case"

class IndicesTest < ApplicationSystemTestCase
  setup do
    @index = indices(:one)
  end

  test "visiting the index" do
    visit indices_url
    assert_selector "h1", text: "Indices"
  end

  test "should create index" do
    visit indices_url
    click_on "New index"

    click_on "Create Index"

    assert_text "Index was successfully created"
    click_on "Back"
  end

  test "should update Index" do
    visit index_url(@index)
    click_on "Edit this index", match: :first

    click_on "Update Index"

    assert_text "Index was successfully updated"
    click_on "Back"
  end

  test "should destroy Index" do
    visit index_url(@index)
    click_on "Destroy this index", match: :first

    assert_text "Index was successfully destroyed"
  end
end
