require 'spec_helper'

describe "Lessons" do
	subject { page }

	describe "new" do
		let!(:subject1) { FactoryGirl.create(:subject) }
		before { visit new_subject_lesson_path(subject1) }
		it { should have_content "Nowa lekcja" }
		it { should have_selector "form" }
	end
end
