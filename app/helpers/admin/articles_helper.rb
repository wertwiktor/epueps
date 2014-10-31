module Admin::ArticlesHelper
  def article_form_url(article)
    if article.new_record?
      admin_articles_path(article)
    else
      admin_article_path(article)
    end
  end


  def article_form_submit(article)
    if article.new_record?
      'Dodaj artykuł'
    else
      'Zapisz zmiany'
    end
  end

end
