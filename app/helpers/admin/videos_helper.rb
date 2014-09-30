module Admin::VideosHelper

  def video_form_url(subject, lesson, video)
    if video.new_record?
      admin_subject_lesson_videos_path(subject, lesson, video)
    else
      admin_subject_lesson_video_path(subject, lesson, video)
    end
  end


  def video_form_submit(video)
    if video.new_record?
      "Dodaj film"
    else
      "Zapisz zmiany"
    end
  end
end
