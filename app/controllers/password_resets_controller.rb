class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "パスワード再設定フォームを送付しました。フォームにアクセスしてパスワードを変更してください。"
  		redirect_to root_url
  	else
  		flash[:danger] = "未登録のメールアドレスです。新規登録をお願いします。"
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "パスワードが入力されていません。")
      render 'edit'
    elsif @user.update_attriburtes(user_params)
      log_in @User
      flash[:info] = "パスワードが変更されました。"
      redirect_to @root_url
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # beforeフィルタ

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザを確認する
    def valid_user
      unless(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # 再設定用トークンが期限内か否かを確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定フォームの有効期限が切れました。もう1度「パスワードを忘れた場合はこちら」から進んでください。"
        redirect_to new_password_reset_url
      end
    end
end