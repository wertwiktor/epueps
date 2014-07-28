require 'spec_helper'

describe "StaticPages" do

	subject { page }
  
  describe "Home page" do
  	let!(:subject1) { FactoryGirl.create(:subject, popularity: 3) }
  	let!(:subject2) { FactoryGirl.create(:subject, popularity: 5) }


  	before { visit root_path }

  	it { should have_title "Platforma ePUEPS" }
  	it { should have_content "Witamy" }
  	it { should have_link "Przeglądaj kursy", href: subjects_path }
  	# TODO: Add href to "Zaloguj się" link
  	it { should have_link "Zaloguj się" }

  	it { should have_selector("h1", text: "Dostępne kursy") }
  	it { should have_link "Wszystkie kursy", href: subjects_path }

  	it { should have_selector("h2", text: subject1.name) }
  	it { should have_content subject1.description }
  	it { should have_selector("img") }
  	it { should have_link "Zacznij kurs", subject_path(subject1) }

  	it "should have subjects ordered by popularity" do
  		expect(Subject.popular).to eq [subject2, subject1]
  	end

  end
end
