require 'rails_helper'

RSpec.describe "AdminSubjectPages", :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }
  let!(:subject1) { FactoryGirl.create(:subject, name: "S1") }
  let!(:subject2) { FactoryGirl.create(:subject, name: "S2") }
  let!(:lesson1) { FactoryGirl.create(:lesson, subject: subject1) }

  subject { page }

  describe "index page" do
    context "with no privileges" do
      before { visit admin_subjects_path }

      it { should have_content "Nie masz uprawnień" }
    end

    context "as an admin" do
      before do
        sign_in admin
        visit admin_subjects_path 
      end

      it { should have_content "Wszystkie przedmioty" }

      it { should have_content "S1" } 
      it { should have_content "S2" }

      it { should have_link "Usuń", 
             href: admin_subject_path(subject2) }

      it { should have_content subject1.lessons.count }
      it { should have_content subject2.lessons.count }

    end
  end
end
