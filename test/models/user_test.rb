require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(email:"user@example.com", password: "foobar", password_confirmation: "foobar")
	end

	test "正当なユーザか？" do
		assert @user.valid?
	end

	test "emailがない場合は不正" do
		@user.email = "     "
		assert_not @user.valid?
	end

	test "emailの文字数上限は255文字" do
		@user.email = "a"*244+"@example.com"
		assert_not @user.valid?
	end

	test "正当なメールアドレスか" do
		valid_address = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn] 
		valid_address.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} は正当"
		end 
	end

	test "不正なメールアドレスか" do
		invalid_address = %w[user@example,com user_at_foo.org.com user.name@example.foo@bar_baz.com foo@abar+baz.cn] 
		invalid_address.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} は不正"
		end 
	end

	test "メールアドレスの重複は不可" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "パスワードが空白でないか" do
		@user.password = @user.password_confirmation = ""*6
		assert_not @user.valid?
	end

	test "パスワードが6文字以上か" do
		@user.password = @user.password_confirmation = "a"*5
		assert_not @user.valid?
	end

	test "保存前にメールアドレスが小文字になっているか" do
		@user.email = "USER@EXAMPLE.COM"
		@user.save
		assert_equal "user@example.com", @user.reload.email
	end

	test "別ブラウザでログアウトされた場合に(二重ログアウトを避けるため)authenticated?にfalseを返す" do
		assert_not @user.authenticated?('')
	end
	
end
