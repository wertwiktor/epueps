require 'rails_helper'

RSpec.describe "ArticlePages", :type => :request do
  
  let!(:user) { FactoryGirl.create(:user) }
  let!(:article1) { FactoryGirl.create(:article, user_id: user.id) }

  subject { page }

  describe "index" do
    before { visit articles_path }

    it { should have_content article1.title }
    it { should have_content article1.body }

    it { should have_title normal_title("Wszystkie artykuły") }
  end
end

