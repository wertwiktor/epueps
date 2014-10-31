module SubjectsHelper

  def subject_form_url(subject)
    if subject.new_record?
      admin_subjects_path(subject)
    else
      admin_subject_path(subject)
    end
  end


  def subject_form_submit(subject)
    if subject.new_record?
      'Dodaj przedmiot'
    else
      'Zapisz zmiany'
    end
  end

end
