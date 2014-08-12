module CurrentLesson 

  # returns lesson's current or
  # first video if lesson hadn't been played yet 

  def current_lesson_video(lesson)
    lesson_id = params[:current_video]            || 
      current_lesson_video_from_cookie(lesson)  ||
      nil

    lesson_id ? Video.find(lesson_id) : lesson.videos.first
  end

  def current_lesson_video_from_cookie(lesson)
    cookies["l-#{lesson.id}-current-video"]
  end

  def create_example_video(lesson)
    lesson.videos.create(name: "example", 
      link: "https://youtube.com/watch?v=example")
  end

end