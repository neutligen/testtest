require 'test_helper'

class UsersControllerTest < ActionController::TestCase

	def setup
		@user = users(:michael)
    @other_user = users(:archer)
	end

  test "ログインせずにインデックスにアクセスがあったら、ログイン画面にリダイレクトする" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "ログインせずにeditした場合はリダイレクト" do
  	get :edit, id: @user
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "ログインせずにupdateした場合はリダイレクト" do
  	get :edit, id: @user, user: {password: "foobarbaz", password_confiemation: "foobarbaz"}
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "別アカウントのユーザがeditに入ろうとしたらリダレクトさせる" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "別アカウントのユーザがupdateしようとしたらリダレクトさせる" do
    log_in_as(@other_user)
    get :update, id: @user, user: {password: "foobarbaz", password_confiemation: "foobarbaz"}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログインせずに削除しようとしたらログイン画面にリダイレクトさせる" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "非管理者が削除しようとしたホーム画面にリダイレクトさせる" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end
