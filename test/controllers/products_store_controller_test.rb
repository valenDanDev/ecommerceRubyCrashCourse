require "test_helper"

class ProductsStoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_store_index_url
    assert_response :success
  end
end
