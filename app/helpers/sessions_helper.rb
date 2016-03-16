module SessionsHelper

  # 渡されたユーザでログインする
  def log_in(user)
  	session[:user_id] = user.id
  end

  # 現在ログインしているユーザをセッションから取得
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザがログインしているか否かを判断
  def logged_in?
  	!current_user.nil?
  end

end
