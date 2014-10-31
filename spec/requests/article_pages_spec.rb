require 'rails_helper'

RSpec.describe 'ArticlePages', type: :request do
  
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:article1) { FactoryGirl.create(:article, user_id: admin.id) }

  subject { page }

  describe '#index' do
    before { visit articles_path }

    it { should have_content article1.title }
    it { should have_content article1.body }

    it { should have_title normal_title('Wszystkie artykuły') }
  end

  describe '#show' do
    before { visit article_path(article1) }

    it { should have_content article1.title }
    it { should have_content article1.body }
  end

  context 'admin' do
    before { sign_in admin }

    describe '#index' do
      before { visit admin_articles_path }

      it { should have_content 'Wszystkie artykuły' }
      it { should have_title 'Wszystkie artykuły' }
      it { should have_content article1.title }
      it { should have_link 'Usuń' }
      it { should have_link 'Edytuj' }

      it { should have_link 'Nowy artykuł' }

    end

    describe '#new' do
      before { visit new_admin_article_path }

      it { should have_content 'Dodaj artykuł' }
      it { should have_button 'Dodaj artykuł' }

      describe 'adding a new article' do
        before do
          fill_in 'Tytuł',    with: 'Title'
          fill_in 'Treść',    with: 'Content'
        end

        it 'should change the article count' do
          expect { click_button 'Dodaj artykuł' }
            .to change(Article, :count).by(1)
        end

        it 'should show add the article' do
          click_button 'Dodaj artykuł'

          expect(page).to have_content 'Dodano artykuł'
        end
      end
    end
  end
end
