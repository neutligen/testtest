require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "アカウント有効化のテスト" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "アカウント有効化", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match /[a-z\d\w\-.]+/, mail.body.encoded
    # assert_match user.activation_token, mail.body.encoded
    # assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "パスワード再設定フォームのテスト" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "パスワード再設定フォーム", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match /[a-z\d\w\-.]+/, mail.body.encoded
    # assert_match user.reset_token, mail.body.encoded
    # assert_match CGI::escape(user.email), mail.body.encoded
  end

end
