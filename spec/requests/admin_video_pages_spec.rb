require 'rails_helper'

RSpec.describe "AdminVideoPages", :type => :request do
  
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:subject1) { FactoryGirl.create(:subject) }
  let!(:lesson) { FactoryGirl.create(:lesson, 
                                     subject_id: subject1.id) }


  subject { page }

  before do
    sign_in admin
  end

  describe "new video page" do
    before do
      visit new_admin_subject_lesson_video_path(subject1, lesson)
    end

    it { should have_title admin_title("Dodaj film") }
    it { should have_content "Dodaj film" }
    it { should have_content subject1 }
    it { should have_content lesson }
    it { should have_button "Dodaj film" } 


    describe "submitting the form" do

      context "with invalid data" do 
        before do
          # delete example video
          lesson.videos.first.destroy
          fill_in "Nazwa",      with: "fff"
          fill_in "Link",       with: "invalid"
        end

        it "should not change the video count" do
          expect { click_button "Dodaj film" }.
            not_to change(Video, :count)
        end

        describe "flash message" do
          before { click_button "Dodaj film" }

          it { should have_content "Wystąpiły błędy" }
        end
      end

      context "with valid data" do
        before do
          #delete example video
          lesson.videos.first.destroy
          fill_in "Nazwa",  with: "Video1"
          fill_in "Link",   with: "youtube.com/watch?v=123"
        end

        it "should change the video count" do
          expect { click_button "Dodaj film" }.
            to change(Video, :count).by(1)
        end

        describe "flash message" do
          before { click_button "Dodaj film" }

          it { should have_content "Dodano film" }
          it { should have_content "Video1" }
        end
      end
    end
  end
end
