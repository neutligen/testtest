require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
  	@base_title = "Habitize"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title","#{@base_title}" 
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title","#{@base_title} | ヘルプ" 
  end

  test "aboutページが表示される" do
  	get :about
  	assert_response :success
  	assert_select "title","#{@base_title} | ハビタイズとは" 
  end

  test "問い合わせページが表示される" do
  	get :contact
  	assert_response :success
  	assert_select "title", "#{@base_title} | お問い合わせ"
  end
end
