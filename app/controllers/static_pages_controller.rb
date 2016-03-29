class StaticPagesController < ApplicationController
	before_action :user_set

  def home
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
