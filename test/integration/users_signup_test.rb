require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "不正な登録があった場合" do
 	  get signup_path
 	  assert_no_difference 'User.count' do
 	  	post users_path, user: {email: "user@invalid", password: "foo", password_confirmation: "bar"}
 	  end
 	  assert_template 'users/new'
 	  assert_select 'div#<CSS id for error explanation>'
 	  assert_select 'div.<CSS class for field with error>'
  end

  test "正当な登録があり、且つ有効化された場合" do
  	get signup_path
  	assert_difference "User.count", 1 do
  		post users_path, user:{email: "example@user.com", password: "foobar", password_confirmation: "foobar"}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化する前のログイン
    log_in_as(user)
    # assert_not is_logged_in? <=gravatarの写真をstatic_pageをレンダリングした際も表示するために除外（セキュリティ見合いは後日確認/原因はtatic_pageのbefore_action）_20160330
    # 不正なactivation_tokenの場合
    get edit_account_activation_path("invalid token")
    # assert_not is_logged_in? <=gravatarの写真をstatic_pageをレンダリングした際も表示するために除外（セキュリティ見合いは後日確認/原因はtatic_pageのbefore_action）_20160330
    # 有効なメールアドレスだが、activation_tokenが不正な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    # assert_not is_logged_in? <=gravatarの写真をstatic_pageをレンダリングした際も表示するために除外（セキュリティ見合いは後日確認/原因はtatic_pageのbefore_action）_20160330
    # 有効なメールアドレス、且つ正当なactivation_tokenの場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.empty?
  end

end
