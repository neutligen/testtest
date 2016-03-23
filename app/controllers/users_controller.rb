class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:info] = "Habitaizeにご登録いただき、ありがとうございます！"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新成功！
    else
      render 'edit'
    end
  end

  private

	  def user_params
	  	params.require(:user).permit(:email, :password, :password_confirmation)
	  end

end
