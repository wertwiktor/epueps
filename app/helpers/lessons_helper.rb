module LessonsHelper

  def lesson_form_url(subject, lesson)
    if lesson.new_record?
      admin_subject_lessons_path(subject, lesson)
    else
      admin_subject_lesson_path(subject, lesson)
    end
  end


  def lesson_form_submit(lesson)
    if lesson.new_record?
      "Dodaj lekcję"
    else
      "Zapisz zmiany"
    end
  end

end
