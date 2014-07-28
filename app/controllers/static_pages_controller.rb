class StaticPagesController < ApplicationController

	def home
		# if user not logged in
		@splash = true
		@subjects = Subject.popular.limit(3)
	end

	def contact
		
	end

	def about
		
	end
end
