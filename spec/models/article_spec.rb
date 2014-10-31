require 'rails_helper'

RSpec.describe Article, :type => :model do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    @article = user.articles.create(title: "Title", body: "Body")
  end

  subject { @article }

  describe "when title is blank" do
    before { @article.title = " " }

    it { should_not be_valid }
  end

  describe "when body is blank" do
    before { @article.body = " " }

    it { should_not be_valid }
  end

  describe "when user id is blank" do
    before { @article.user_id = nil }

    it { should_not be_valid }
  end

  describe "markdown renderer" do
    before { @article.body = '# Header' }

    it "shoud render correct html" do
      expect(@article.body_text).to eq "<h1>Header</h1>\n"
    end
  end

  describe '#short_title' do
    before { @article.title = "some long title for this post" }

    it "should show only 5 words" do
      expect(@article.short_title).to eq "some long title for this..."
    end
  end
end

