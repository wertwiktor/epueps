module YoutubeUtilities
  def validate_youtube_link(link)
    video_id = link.gsub(/^.*watch\?v\=/, "").gsub(/\&.*$/, "")
    "https://youtube.com/watch?v=#{video_id}"
  end
end