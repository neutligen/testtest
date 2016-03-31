class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    # gravatarでnavbarに画像を表示するためには@userにログイン中のユーザが格納されている必要があるための対応_20160328
    @user = current_user
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @to_do_lists = @user.to_do_lists.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      @user.send_activation_email
  		flash[:info] = "Habitizeにご登録いただき、ありがとうございます！ お送りしたメールからアカウントを有効化してください。"
      Category.create(category_name: "カテゴリ(デフォルト)", user_id: @user.id)
  		redirect_to root_url
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
      flash[:success] = "パスワードを更新しました。"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to users_url
  end

  private

	  def user_params
	  	params.require(:user).permit(:email, :password, :password_confirmation)
	  end

    # beforeフィルター

    # 正しいユーザーの作業か確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
