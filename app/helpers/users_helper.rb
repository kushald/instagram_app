module UsersHelper

	def exclude_users(username, user_id)
		Constant::EXCLUDE_USER_NAMES.include?(username) || Constant::EXCLUDE_USER_IDS.include?(user_id)
	end
end
