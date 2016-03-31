class ToDoListsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy, :show, :update, :edit]
	before_action :correct_user, only: [:destroy, :edit]

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

	def show
		@user = current_user
		@to_do_list = current_user.to_do_lists.find(params[:id])
	end

	def update
	  @to_do_list = current_user.to_do_lists.find(params[:id])
	  if @to_do_list.update_attributes(to_do_list_params)
	    redirect_to root_url
	  else
	    render 'static_pages/home'
	  end
  end

  def edit
    @to_do_list.update_attribute(:ending_flg, 1)
		flash[:info] = "完了一覧に移動しました。"
		redirect_to root_url
  end

	def destroy
		@to_do_list.destroy
		flash[:info] = "ToDoリストを削除しました。"
		redirect_to request.referrer || root_url
	end

	private

	  def to_do_list_params
	  	params.require(:to_do_list).permit(:title, :category_id, :priority_flg, :schedule_sta, :schedule_end, :comment, :ending_flg, :reminder_mail, :picture)
	  end

	  def correct_user
	  	@to_do_list = current_user.to_do_lists.find_by(id: params[:id])
	  	redirect_to root_url if @to_do_list.nil?
	  end
	end

