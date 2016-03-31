module UsersHelper

	def gravatar_for(user, option={size: 80})
		if logged_in?
			gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
			size = option[:size]
			gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
			# image_tag(gravatar_url, alt: user.email[/[a-z\d\w\-.]+/,0],class:"gravatar")
			link_to(image_tag(gravatar_url, alt: user.email[/[a-z\d\w\-.]+/,0],class:"gravatar"), to_do_lists_path) 
		else
			link_to(image_tag("wadachi_2_icon.jpg", alt:"wadachi_2_icon.jpg"), "http://www.i-noh.com")
		end
	end
	
end
