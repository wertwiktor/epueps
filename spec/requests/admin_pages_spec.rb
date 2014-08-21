require 'rails_helper'

RSpec.describe "AdminPages", :type => :request do

  let!(:admin) { FactoryGirl.create(:admin) }

  subject { page }
  
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

      it { should have_content "Panel administracyjny" }
      it { should have_content "Zalogowano jako: #{admin.email}" }

      it { should have_content "Przedmioty: " }
      it { should have_content "Lekcje: " }
      it { should have_content "Filmy: " }
      it { should have_content "Użytkownicy: " }
    end
  end
end
