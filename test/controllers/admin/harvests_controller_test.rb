require "test_helper"

class Admin::HarvestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_harvests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_harvests_show_url
    assert_response :success
  end
end
