require 'test_helper'

class ToDoListsControllerTest < ActionController::TestCase
  
  def setup
  	@to_do_list = to_do_lists(:orange)
  end

  test "ログインせずにタイトル入力したらログイン画面にリダイレクト" do
  	assert_no_difference 'ToDoList.count' do
  		post :create, to_do_list: { title: "マラソン" }
  	end
  	assert_redirected_to login_url
  end

  test "ログインせずに削除したらログイン画面にリダイレクト" do
  	assert_no_difference 'ToDoList.count' do
  		delete :destroy, id: @to_do_list
  	end
  	assert_redirected_to login_url
  end

  test "自分以外のユーザのToDoリストを削除するとrootにリダイレクトする" do
    log_in_as(users(:michael))
    to_do_list = to_do_lists(:ants)
    assert_no_difference 'ToDoList.count' do
      delete :destroy, id: to_do_list
    end
    assert_redirected_to root_url
  end
end
