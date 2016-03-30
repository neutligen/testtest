class StaticPagesController < ApplicationController
	before_action :user_set

  def home
    if logged_in?
      @to_do_list = @user.to_do_lists.build
      @to_do_lists = @user.to_do_lists.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  private

  # gravatarでnavbarに画像を表示するためには@userにログイン中のユーザが格納されている必要があるための対応_20160328
  def user_set
    if current_user
      @user = current_user
    end
  end
end
