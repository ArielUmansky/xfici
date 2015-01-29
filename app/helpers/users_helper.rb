module UsersHelper

	def avatar_for(user, size) 
		if (user.avatar.url.present?)
			image_tag(user.avatar.url, width: size, height: size, class: "avatar")
		else
			image_tag("http://res.cloudinary.com/dwf4bsmoc/image/upload/v1422421465/default_qjzgfc.png", width: size, height: size, class: "avatar")
		end
	end
end