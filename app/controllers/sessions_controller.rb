class SessionsController < ApplicationController
  before_action :user_set

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
    		log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    		redirect_back_or user
      else
        message = "アカウントが有効化されていません。"
        message += "お送りしたメールからアカウントを有効化してください。"
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = 'メールアドレスかパスワードが誤っています。'
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end

  # gravatarでnavbarに画像を表示するためには@userにログイン中のユーザが格納されている必要があるための対応_20160328
  def user_set
    if current_user
      @user = current_user
    end
  end
  
end
