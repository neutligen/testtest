module UsersHelper

	def gravatar_for(user, option={size: 80})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = option[:size]
		gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url,alt: user.email[/[a-z\d\w\-.]+/,0],class:"gravatar")
	end
	
end
