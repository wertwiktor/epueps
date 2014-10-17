class StaticPagesController < ApplicationController

	def home
		@splash = true 
		@subjects = Subject.popular.limit(3)
		@articles = Article.includes(:user).all
	end

	def contact
		
	end

	def about
		
	end
end
