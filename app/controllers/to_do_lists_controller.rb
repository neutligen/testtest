class ToDoListsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@user = current_user
		@to_do_lists = @user.to_do_lists.paginate(page: params[:page])
		@to_do_list = @user.to_do_lists.build(to_do_list_params)
		if @to_do_list.save
			flash[:info] = "ToDoリストが登録されました。"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
		@to_do_list.destroy
		flash[:info] = "ToDoリストを削除しました。"
		redirect_to request.referrer || root_url
	end

	private

	  def to_do_list_params
	  	params.require(:to_do_list).permit(:title, :picture)
	  end

	  def correct_user
	  	@to_do_list = current_user.to_do_lists.find_by(id: params[:id])
	  	redirect_to root_url if @to_do_list.nil?
	  end

end
