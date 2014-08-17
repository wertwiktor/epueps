require 'rails_helper'

RSpec.describe "Users", :type => :request do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin, email: "foo@baz.com") }

  subject { page }

  describe "sign in page" do
    before { visit new_user_session_path }

    it { should have_content "Zaloguj się" }
    it { should have_link "Zaloguj się" }
    it { should have_css "input[name='user[email]']" }
    it { should have_css "input[name='user[password]']" }

    describe "after signing in with valid data" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Hasło",    with: user.password
        click_button "Zaloguj się"
      end


      it { should have_content "Zalogowano się pomyślnie" }
      it { should have_content "Wyloguj się" }

      describe "after signing out" do
        before { click_link "Wyloguj się" }

        it { should have_content "Wylogowano się pomyślnie" }
        it { should have_content "Zaloguj się" }
      end

    end
  end

end
