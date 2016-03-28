require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:michael)
  end

  test "不正な更新" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user:{password: "foo", password_confirmation: "bar" }
  	assert_template 'users/edit'
  end

  test "正当な更新 且つ フレンドリーフォワーディング" do
  	get edit_user_path(@user)
    log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	patch user_path(@user), user: { password: "foobarbaz", password_confirmation: "foobarbaz"}
  	assert_not flash.empty?
  	assert_redirected_to @user
  end

end
