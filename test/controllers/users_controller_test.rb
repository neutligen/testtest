require 'test_helper'

class UsersControllerTest < ActionController::TestCase

	def setup
		@user = users(:michael)
	end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "ログインせずにeditした場合はリダイレクト" do
  	get :edit, id: @user
  	assert_not flash.empty?
  	assert_redirect_to login_url
  end

  test "ログインせずにupdateした場合はリダイレクト" do
  	get :edit, id: @user, user: {password: "foobarbaz", password_confiemation: "foobarbaz"}
  	assert_not flash.empty?
  	assert_redirect_to login_url
  end


end
