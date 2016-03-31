class CategoriesController < ApplicationController
	 before_action :logged_in_user

	def index
		@user = current_user
		@categories = @user.categories.paginate(page: params[:page])
		@category = @user.categories.build
	end

	def create
		@category = current_user.categories.build(category_params)
		if @category.save
			flash[:info] = "カテゴリが追加されました。"
			redirect_to categories_path
		else
			render 'categories_path'
		end
	end

	def destroy
		@category = current_user.categories.find_by(id: params[:id])
		if @category.present?
			@category.destroy
			flash[:info] = "カテゴリを削除しました。"
			redirect_to categories_path
		else
			flash[:danger] = "無効な操作です。"
			redirect_to categories_path
		end
	end

	private

	  def category_params
	  	params.require(:category).permit(:category_name)
	  end

end
