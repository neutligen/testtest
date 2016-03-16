require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end
  
  test "エラーのフラッシュが残らない"  do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, session: {email:"", password:""}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  end

  test "正当な情報でログインした場合の画面" do
  	get login_path
  	post login_path, session: {email: @user.email, password: "password"}
  	assert_redirected_to @user
  	follow_redirect!
  	assert_select "a[href=?]", login_path, count: 0
  	assert_select "a[href=?]", logout_path
  	# assert_select "a[href=?]", user_path(@user)
  end
end
