require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
  	@user = users(:michael)
  end

  test "to_do_listの一覧画面" do
  	log_in_as(@user)
  	get user_path(@user)
  	assert_template 'users/show'
  	assert_select 'title', full_title(@user.email[/[a-z\d\w\-.]+/,0])
  	assert_select 'h1', text: @user.email[/[a-z\d\w\-.]+/,0]
  	assert_select 'a>img.gravatar'
  	assert_match @user.to_do_lists.count.to_s, response.body
  	assert_select 'div.pagination'
  	@user.to_do_lists.paginate(page: 1).each do |to_do_list|
  		assert_match to_do_list.title, response.body
  	end
  end
end
