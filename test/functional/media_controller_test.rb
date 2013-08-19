require 'test_helper'

class MediaControllerTest < ActionController::TestCase
  test "should get likes" do
    get :likes
    assert_response :success
  end

  test "should get comments" do
    get :comments
    assert_response :success
  end

end
