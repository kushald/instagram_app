module UsersHelper

	def exclude_users(username, user_id)
		Constant::EXCLUDE_USER_NAMES.include?(username) || Constant::EXCLUDE_USER_IDS.include?(user_id)
	end

	def url_restrict(type,profile_id)
		url = ""
		if @current_user.logged_in_user
	    url = type == "followed-by" ? "/followed-by/" : "/following"
	    url = url + "?id=#{profile_id}"
	  end
	  url
	end
end
