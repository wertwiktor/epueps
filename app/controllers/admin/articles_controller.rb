class Admin::ArticlesController < ApplicationController
  include Admin

  layout 'admin'

  before_action :authenticate_admin

  def index
    @articles = SortAndFilterData.call(Article.includes(:user), params)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = 'Dodano artykuł'
      redirect_to admin_articles_path
    else
      flash[:error] = 'Wystąpił błąd'
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      flash[:success] = 'Zapisano zmiany'
      redirect_to admin_articles_path
    else
      flash[:error] = 'Wystąpił błąd'
      render 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
