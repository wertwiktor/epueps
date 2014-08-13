class Video < ActiveRecord::Base
  include YoutubeUtilities

  belongs_to :lesson

  before_save :validate!

  validates :link,
            presence: { message: "Link do filmu nie może być pusty" },
            format: 
            { with: VIDEO_LINK_REGEX,
              message: "Niepoprawny format"
            }
  validates :name,
            presence: { message: "Nazwa filmu nie może być pusta" }
  validates :lesson_id, presence: true


  def embed_link
    link.gsub("watch?v=", "embed/") + video_params
  end

  def thumbnail
    "https://img.youtube.com/vi/#{self.video_id}/1.jpg"
  end



  protected

  def validate!
    self.link = validate_youtube_link(self.link)
  end

  def video_id
    self.link.gsub(/^.*v=/, "")
  end
  
end
