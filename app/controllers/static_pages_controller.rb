class StaticPagesController < ApplicationController

	def home
		@splash = true unless user_signed_in?
		@subjects = Subject.popular.limit(3)
	end

	def contact
		
	end

	def about
		
	end
end
