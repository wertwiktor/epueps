require 'rails_helper'

RSpec.describe "AdminPages", :type => :request do

  let!(:admin) { FactoryGirl.create(:admin) }

  subject { page }

  describe "site's home page when admin is signed in" do
    before do
      sign_in admin
      visit root_path
    end

    it { should have_link "Panel administracyjny", href: admin_path }
  end
  
  describe "index page" do
    context "as not-admin user" do
      before { visit admin_path }
      it { should have_content "Nie masz uprawnień do wykonania tej akcji"}
    end

    context "as an admin" do
      before do
        sign_in admin
        visit admin_path
      end

      it { should have_title admin_title("Panel administracyjny") }
      it { should have_content "Panel administracyjny" }
      it { should have_content "Zalogowano jako: #{admin.email}" }

      it { should have_content "Przedmioty: 0" }
      it { should have_content "Lekcje: 0" }
      it { should have_content "Filmy: 0" }
      it { should have_content "Użytkownicy: 1" }
    end
  end
end
