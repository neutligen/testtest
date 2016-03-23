require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:michael)
  end

  test "不正な更新" do
  	current_user = users(:michael)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user:{email: "foo@invalid", password: "foo", password_confirmation: "bar" }
  	assert_template 'users/edit'
  end

end
