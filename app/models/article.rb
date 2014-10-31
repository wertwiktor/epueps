class Article < ActiveRecord::Base
  belongs_to :user

  validates :title,
            presence: { message: 'Tytuł nie może być pusty' }
  validates :body,
            presence: { message: 'Treść nie może być pusty' }
  validates :user_id, presence: true

  def body_text
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, autolinks: true, tables: true)

    markdown.render(body)
  end

  def short_title
    # TODO: It needs some refactoring
    title.split(' ').first(5).join(' ').concat('...')
  end
end
