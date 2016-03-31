class StaticPagesController < ApplicationController
	before_action :user_set
# モーダルの夢を見たが、"to_key"のエラー(エンティティ(集合)と個別(クリエイト)が共存できないとか)が出ちゃって厳しい_20160406
  # before_action :category_set

  def home
    if logged_in?
      @to_do_list = @user.to_do_lists.build
      @to_do_lists = @user.to_do_lists.paginate(page: params[:page])
      # ユーザに紐づくカテゴリー名前の配列を取り出す
      @cids = @user.category_ids
      # @my_categories = @cids.map { |id| Category.find_by(id: id).category_name }
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def render_to_do_lists_condition
    if !@to_do_list.ending_flg
      render :partial => @to_do_lists
    end
  end

  private

  # gravatarでnavbarに画像を表示するためには@userにログイン中のユーザが格納されている必要があるための対応_20160328
  def user_set
    @user ||= current_user
  end

# モーダルの夢を見たが、"to_key"のエラー(エンティティ(集合)と個別(クリエイト)が共存できないとか)が出ちゃって厳しい_20160406
  # def category_set
  #   @category = @user.categories.paginate(page: params[:page])
  # end 

end
