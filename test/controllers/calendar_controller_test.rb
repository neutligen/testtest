require 'test_helper'

class CalendarControllerTest < ActionController::TestCase

  def setup
  	@user = users(:michael)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
