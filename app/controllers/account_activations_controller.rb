class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:info] = "ありがとうございます！　アカウントが有効化されました。"
			redirect_to root_url
		else
			flash[:danger] = "無効な操作です。"
			redirect_to root_url
		end
	end
end
