class StaticPagesController < ApplicationController
	before_action :user_set

  def home
    if logged_in?
      @to_do_list = @user.to_do_lists.build
      @to_do_lists = @user.to_do_lists.paginate(page: params[:page])
      # ユーザに紐づくカテゴリー名前の配列を取り出す
      @cids = @user.category_ids
      @my_categories = @cids.map { |id| Category.find_by(id: id).category_name }
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
      @user ||= current_user
  end
end
