require "application_system_test_case"

class AlbumAttachmentsTest < ApplicationSystemTestCase
  setup do
    @album_attachment = album_attachments(:one)
  end

  test "visiting the index" do
    visit album_attachments_url
    assert_selector "h1", text: "Album attachments"
  end

  test "should create album attachment" do
    visit album_attachments_url
    click_on "New album attachment"

    fill_in "Album", with: @album_attachment.album_id
    fill_in "Img url", with: @album_attachment.img_url
    click_on "Create Album attachment"

    assert_text "Album attachment was successfully created"
    click_on "Back"
  end

  test "should update Album attachment" do
    visit album_attachment_url(@album_attachment)
    click_on "Edit this album attachment", match: :first

    fill_in "Album", with: @album_attachment.album_id
    fill_in "Img url", with: @album_attachment.img_url
    click_on "Update Album attachment"

    assert_text "Album attachment was successfully updated"
    click_on "Back"
  end

  test "should destroy Album attachment" do
    visit album_attachment_url(@album_attachment)
    click_on "Destroy this album attachment", match: :first

    assert_text "Album attachment was successfully destroyed"
  end
end
