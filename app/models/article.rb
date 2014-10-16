class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, 
            presence: { message: "Tytuł nie może być pusty" }
  validates :body,
            presence: { message: "Treść nie może być pusty" }
  validates :user_id, presence: true
end
