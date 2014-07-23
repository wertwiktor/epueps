require 'spec_helper'

describe "StaticPages" do

	subject { page }
  
  describe "Home page" do
  	before { visit root_path }

  	it { should have_title "Platforma ePUEPS" }
  	it { should have_content "Witamy" }
  	it { should have_link "Przeglądaj kursy", href: subjects_path }

  	it { should have_selector("h1", text: "Dostępne kursy") }
  	it { should have_link "Wszystkie kursy", href: subjects_path }
  end
end
