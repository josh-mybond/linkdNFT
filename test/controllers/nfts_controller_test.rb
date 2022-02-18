require "test_helper"

class NftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nft = nfts(:one)
  end

  test "should get index" do
    get nfts_url
    assert_response :success
  end

  test "should get new" do
    get new_nft_url
    assert_response :success
  end

  test "should create nft" do
    assert_difference("Nft.count") do
      post nfts_url, params: { nft: { nft_id: @nft.nft_id, owner_name: @nft.owner_name, token_link: @nft.token_link, wallet_address: @nft.wallet_address } }
    end

    assert_redirected_to nft_url(Nft.last)
  end

  test "should show nft" do
    get nft_url(@nft)
    assert_response :success
  end

  test "should get edit" do
    get edit_nft_url(@nft)
    assert_response :success
  end

  test "should update nft" do
    patch nft_url(@nft), params: { nft: { nft_id: @nft.nft_id, owner_name: @nft.owner_name, token_link: @nft.token_link, wallet_address: @nft.wallet_address } }
    assert_redirected_to nft_url(@nft)
  end

  test "should destroy nft" do
    assert_difference("Nft.count", -1) do
      delete nft_url(@nft)
    end

    assert_redirected_to nfts_url
  end
end
