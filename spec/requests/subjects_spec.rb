require 'spec_helper'

describe "Subject" do
	subject { page }

	describe "index page" do
		let!(:subject1) { FactoryGirl.create(:subject, name: "S1", popularity: 3) }
  	let!(:subject2) { FactoryGirl.create(:subject, name: "S2", popularity: 5) }

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
  end

end
