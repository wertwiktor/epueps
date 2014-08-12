class Lesson < ActiveRecord::Base

  # has_many  :lesson_resources
  has_many :videos, dependent: :destroy

  after_save :add_example_video

  belongs_to :subject

  validates :subject_id,  presence: true
  validates :name,        presence:  
                          { message: "Nazwa nie może być pusta" }
  validates :description, presence: 
                          { message: "Opis nie może być pusty" }
                      
  # TODO: Add other resources
  def resources
    videos
  end

  private

  def add_example_video
    self.videos.build(name: "Example(delete this later)", 
      link: "https://youtube.com/watch?v=example")
  end
  
end
