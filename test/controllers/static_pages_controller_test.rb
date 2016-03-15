require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title","Habitize | ホーム" 
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title","Habitize | ヘルプ" 
  end

  test "aboutページが表示される" do
  	get :about
  	assert_response :success
  	assert_select "title","Habitize | ハビタイズとは" 
  end
end
