require 'test_helper'

class ToDoListsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:michael)
  end

  test "ToDoListのインターフェース周りのテスト" do
  	log_in_as(@user)
  	get root_path
  	assert_select 'div.pagination'
  	# 無効な登録
  	assert_no_difference 'ToDoList.count' do
  		post to_do_lists_path, to_do_list: {title: ""}
  	end
  	assert_select 'div#error_explanation'
    # 有効な登録
    content = "空欄はダメらしい。。。"
    assert_difference 'ToDoList.count', 1 do
    	post to_do_lists_path to_do_list: {title: content, category_id: 1, priority_flg: "lite"}
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_to_do_list = @user.to_do_lists.paginate(page: 1).first
    assert_difference 'ToDoList.count', -1 do
    	delete to_do_list_path(first_to_do_list)
    end
  end
end
