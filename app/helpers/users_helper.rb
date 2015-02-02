module UsersHelper

	def avatar_for(user, size)
	 #binding.pry 
	  if !user.avatar.filename.nil?  
	  	cl_image_tag(user.avatar.filename, :radius=>10, :width=>size, :height=>size, :crop=>:fill, class: "avatar")
	  else
	  	cl_image_tag("default_qjzgfc.png", :radius=>10, :width=>size, :height=>size, :crop=>:fill, class: "avatar")
	  end
	end
end