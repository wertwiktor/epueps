module YoutubeUtilities

  VIDEO_LINK_REGEX = /\A(https?:\/\/)?w{3}?\.?youtube\.com\/watch\?v=[a-z0-9\-\_\,\.]+.*\z/i 

  def validate_youtube_link(link)
    video_id = link.gsub(/^.*watch\?v\=/, "").gsub(/\&.*$/, "")
    "https://youtube.com/watch?v=#{video_id}"
  end

  def video_params
    "?rel=0&fs=1&autohide=0&showinfo=0"
  end

end