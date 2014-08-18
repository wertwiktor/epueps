module ApplicationHelper
	def full_title(page_title)
		base_title = "Platforma ePUEPS"

		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def sign_in_out_link
		if user_signed_in?
			link_to "Wyloguj się", destroy_user_session_path, method: :delete
		else
			link_to "Zaloguj się", new_user_session_path
		end
	end
	
end
