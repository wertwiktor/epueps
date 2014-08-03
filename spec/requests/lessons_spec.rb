require 'rails_helper'

describe "Lessons" do
	subject { page }

	describe "new" do
		let!(:subject1) { FactoryGirl.create(:subject) }
		before { visit new_subject_lesson_path(subject1) }
		it { should have_content "Nowa lekcja" }
		it { should have_selector "form" }

		describe "it should create a new lesson" do
			before do
				@lesson = subject1.lessons.create(name: "lesson", 
					description: "lorem", video_link: "youtube.com/watch?v=f4")
				fill_in "Nazwa", with: @lesson.name
				fill_in "Opis", with: @lesson.description
				fill_in "Adres filmu", with: @lesson.video_link

				click_button "Dodaj lekcję"
			end

			it { should have_content "Dodano lekcję" }
			it { should have_content @lesson.name }
		end

		describe "for blank data" do
			before { click_button "Dodaj lekcję" }

			it { should have_content "Wystąpiły błędy w formularzu." }
		end

		describe "for invalid video link" do
			before do
				fill_in "Adres filmu", with: "lorem"
				click_button "Dodaj lekcję"
			end

			it { should have_content "Wystąpiły błędy w formularzu" }
			it { should have_content "Niepoprawny format" }
		end
	end
end
