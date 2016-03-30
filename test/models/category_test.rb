require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

	def setup
		@category = Category.new(category_name: "カテゴリ", user_id: 1)
	end

	test "正当なカテゴリ登録を確認" do
		assert @category.valid?
	end

	test "ユーザーIDは必須" do
		@category.user_id = nil
    assert_not @category.valid?
  end

  test "カテゴリ名は必須" do
  	@category.category_name = nil
  	assert_not @category.valid?
  end
  
end
