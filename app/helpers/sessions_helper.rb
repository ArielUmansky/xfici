module SessionsHelper



	def current_user?(user)
		user==current_user
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	def signed_in_user
		unless user_signed_in?
			store_location
			redirect_to new_user_session, notice: "Pleas sign in."
		end
	end

end