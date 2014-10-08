class Lesson < ActiveRecord::Base

  # has_many  :lesson_resources
  has_many  :videos, 
            dependent: :destroy, 
            after_add: :destroy_example_video

  belongs_to :subject, counter_cache: true

  default_scope { order('created_at ASC') }

  after_save :add_example_video

  validates :subject_id,  presence: true
  validates :name,        presence:  
                          { message: "Nazwa nie może być pusta" }
  validates :description, presence: 
                          { message: "Opis nie może być pusty" }
                      
  # TODO: Add other resources
  def resources
    videos
  end

  def thumbnail
    videos.first.thumbnail
  end

  def has_example_video?
    if videos.find_by name: "Example(delete this later)"
      true
    else
      false
    end
  end

  def destroy_example_video(video)
    example = self.videos.find_by name: "Example(delete this later)"
    if example && video != example
      example.destroy!
    end
  end

  def to_s
    name
  end

  private

  def add_example_video
    if videos.empty?
      videos.create(name: "Example(delete this later)", 
        link: "https://youtube.com/watch?v=example")
    end
  end

  
end
