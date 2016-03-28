class StaticPagesController < ApplicationController
	before_action :user_set

  def home
  	@user = current_user
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
  	@user = current_user
  end
end
