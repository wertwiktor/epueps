require 'rails_helper'

RSpec.describe "Users", :type => :request do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin, email: "foo@baz.com") }

  subject { page }

  describe "sign in page" do
    before { visit new_user_session_path }

    it { should have_content "Zaloguj się" }
    it { should have_link "Zaloguj się" }

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

  describe "sign up page" do
    before { visit '/users/sign_up' }

    it { should have_content "Rejestracja" }
    it { should have_content "Email" }
    it { should have_content "Hasło" }
    it { should have_content "Potwierdź hasło" }

    it { should have_button "Zarejestruj się" }

    describe "after signing up with valid data" do
      before do
        visit '/users/sign_up'
        fill_in "Email",            with: 'test@bar.com'
        fill_in "Hasło",            with: 'foobar123'
        fill_in "Potwierdź hasło",  with: 'foobar123'
        click_button "Zarejestruj się" 
      end

      it { should_not have_content "Zarejestruj się" }

      it { should have_content "Witamy, zarejestrowałeś się pomyślnie" }
      it { should have_content "Wyloguj się" }

      it "should redirect to homepage" do
        expect(page).to have_title "Platforma ePUEPS"
        expect(page).to have_content "Dostępne kursy"
      end
    end

    describe "after signing up with invalid data" 
  end

end
