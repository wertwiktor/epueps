class Subject < ActiveRecord::Base
  has_many :lessons, dependent: :destroy

  before_save :validate_link

  include YoutubeUtilities

  scope :popular, -> { order('popularity DESC') }
  scope :recent,   -> { order('created_at DESC') }

  validates :name,  presence: 
                  { message: "Nazwa nie może być pusta" }
  validates :description, presence: 
                  {message: "Opis nie może być pusty"}
  validates :intro_video_link, format: 
                  { with: VIDEO_LINK_REGEX,
                    message: "Niepoprawny format"
                  },
            unless: "intro_video_link.blank?"

  

  def image_src
    if self.image_name
      "subjects/#{self.image_name}" 
    else
      "subjects/subject-#{self.id}.jpg"
    end
  end

  def increase_popularity
    self.popularity += 1
  end

  def to_s
    name
  end


  protected

  def validate_link
    unless intro_video_link.nil?
      self.intro_video_link = validate_youtube_link(self.intro_video_link)
    end
  end
end
