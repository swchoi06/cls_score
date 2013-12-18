require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get preference" do
    get :preference
    assert_response :success
  end

end
