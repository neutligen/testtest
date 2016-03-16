module UsersHelper
	#引数で与えられたユーザーのGravatar画像を返す
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url,alt:user.email[/[a-z\d\w\-.]+/,0],class:"gravatar")
	end
end
