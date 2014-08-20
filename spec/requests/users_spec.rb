require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  fill_in "Email",  with: user.email
  fill_in "Hasło",  with: user.password
  click_button "Zaloguj się"
end

RSpec.describe "Users", :type => :request do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: "bar@boo.com") }
  let!(:admin) { FactoryGirl.create(:admin, email: "foo@baz.com") }

  subject { page }

  describe "sign in page" do
    before { visit new_user_session_path }

    it { should have_content "Zaloguj się" }
    it { should have_link "Zaloguj się" }

    describe "after signing in with valid data" do
      before do
        sign_in(user)
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
    before { visit new_user_registration_path }

    it { should have_content "Rejestracja" }
    it { should have_content "Email" }
    it { should have_content "Hasło" }
    it { should have_content "Potwierdź hasło" }

    it { should have_button "Zarejestruj się" }

    describe "after signing up with valid data" do
      before do
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

    describe "after signing up with invalid data" do
      before do
        fill_in "Email",            with: '.com'
        fill_in "Hasło",            with: 'foobar123'
        fill_in "Potwierdź hasło",  with: 'foobar123'
        click_button "Zarejestruj się" 
      end

      it { should have_content "W formularzu wystąpiły błędy" }
    end
  end

  describe "index page" do

    describe "when user is not signed in" do
      before { visit users_path }
      it { should have_content "Nie masz uprawnień" }
    end

    describe "when user is not an admin" do
      before do
        sign_in(user)
        visit users_path
      end

      it { should have_content "Nie masz uprawnień" }
    end

    describe "when user is an admin" do
      before do
        sign_in(admin)
        visit users_path
      end

      it { should have_content "Wszyscy użytkownicy" }
      it { should have_link "Usuń", href: user_path(user) }
      it { should_not have_link "Usuń", href: user_path(admin) }

      it { should have_css "input[name=search]" }
      it { should have_button "Szukaj" }

      describe "finding users" do

        describe "when user is found the database" do
          before do
            fill_in "search",  with: 'foo'
            click_button "Szukaj"
          end

          it "should find all users" do
            expect(page).to have_content user.email
            expect(page).to have_content admin.email
          end

          it { should have_content "Kryteria: foo" }
        end

        describe "when user is not found in the database" do
          before do
            fill_in "search", with: "notpresent"
            click_button "Szukaj"
          end

          it { should have_content "Nie znaleziono użytkownika" }
          it "should show all users" do
            [user, user2, admin].each do |u|
              expect(page).to have_content u.email
            end
          end
        end

      end
    end
  end


end