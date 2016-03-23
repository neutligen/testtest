require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full_titleヘルパーメソッドに誤字がないかチェック" do
		assert_equal full_title, "Habitize"
		assert_equal full_title("ヘルプ"), "Habitize | ヘルプ"
	end
end
