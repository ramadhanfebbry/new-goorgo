require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get about_us" do
    get :about_us
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get term_of_use" do
    get :term_of_use
    assert_response :success
  end

end
