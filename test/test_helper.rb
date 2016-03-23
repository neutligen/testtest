ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# minitest-reporters gemを使用するために追記_20160324
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # テストユーザがログインしていればtrueを返す。
  def is_logged_in?
  	!session[:user_id].nil?
  end

  def log_in_as(user, option={})
  	password =  option[:password] || 'password'
  	remember_me = option[:remember_me] || '1'
  	if integration_test?
  		post login_path, session:{email: user.email, passeord: password, remember_me: remember_me }
  	else
  		session[:user_id] = user.user_id
  	end
  end

  private

   # 結合テスト内はtrueを返す
   def integration_test?
   	defined?(post_via_redirect)
   end

end
