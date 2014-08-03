require 'rails_helper'

RSpec.describe "Subjects", :type => :request do
  subject { page }

  let!(:subject1) { FactoryGirl.create(:subject, name: "S1", popularity: 3, 
    created_at: 1.hour.ago) }
  let!(:subject2) { FactoryGirl.create(:subject, name: "S2", popularity: 5,
    created_at: 2.hour.ago) }

  describe "index page" do

    before { visit subjects_path }

    it { should have_title "Platforma ePUEPS | Wszystkie kursy" }
    it { should_not have_content "Witamy" }
    it { should_not have_link "Przeglądaj kursy" }
    it { should have_selector("h1", text: "Wszystkie kursy") }
    it { should have_link "Popularne" }
    it { should have_link "Najnowsze" }

    it { should have_content "S1" }
    it { should have_content "S2" }
    it { should have_content subject1.description }

    describe "subjects ordered by most popular" do
      before { click_link "Popularne" }

      it { should have_content /S2.*S1/ }
    end
    describe "subjects ordered by most recent" do
      before { click_link "Najnowsze" }

      it { should have_content /S1.*S2/ }
    end

    describe "with default order" do
      it { should have_content /S1.*S2/ }
    end

  end

  describe "info page" do
    before { visit subject_info_path(subject1) }

    it { should have_content subject1.name}
    it { should have_content subject1.description }
  end

  describe "show page" do
    

    describe "when subject hasn't got any lessons" do
      before { visit subject_path(subject1) }
      it { should have_content "nie ma żadnych lekcji" }
    end

    describe "when subject has at least one lesson" do
      before do
        @lesson = subject1.lessons.create(
          name: "Lesson1", 
          description: "Lorem ipsum1", 
          video_link: "youtube.com/watch?v=asdf")

        @lesson2 = subject1.lessons.create(
          name: "Lesson2", 
          description: "Lorem ipsum2", 
          video_link: "youtube.com/watch?v=asdf")

        visit subject_path(subject1)
      end
      it { should have_content subject1.name }
      it { should have_link @lesson.name }

      describe "remember current lesson" do
        before do
          click_link "Lesson2"
          visit root_path
          visit subject_path(subject1)
        end

        it { should have_content @lesson2.description }
      end
    end
  end

end
