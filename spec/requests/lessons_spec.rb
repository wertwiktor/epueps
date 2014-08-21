require 'rails_helper'

describe "Lessons" do
	subject { page }

	describe "new" do
		let!(:subject1) { FactoryGirl.create(:subject) }
		before { visit new_admin_subject_lesson_path(subject1) }
		it { should have_content "Nowa lekcja" }
		it { should have_selector "form" }

		describe "it should create a new lesson" do
			before do
				@lesson = subject1.lessons.create(name: "lesson", 
					description: "lorem")
				fill_in "Nazwa", with: @lesson.name
				fill_in "Opis", with: @lesson.description

				click_button "Dodaj lekcję"
			end

			it { should have_content "Dodano lekcję" }
			it { should have_content @lesson.name }
		end

		describe "for blank data" do
			before { click_button "Dodaj lekcję" }

			it { should have_content "Wystąpiły błędy w formularzu." }
		end

	end

	# describe "show" do
	# 	let(:subject1) do
	# 	  FactoryGirl.create(:subject)
	# 	end
	# 	before do
	# 	  @lesson = subject1.lessons.create(
	# 	  	name: "Lesson", 
	# 	  	description: "Lorem ipsum",
	# 	  	video_link: "youtube.com/watch?v=433")
		  
	# 	  visit lesson_path(lesson) 
	# 	end
	# end
end
