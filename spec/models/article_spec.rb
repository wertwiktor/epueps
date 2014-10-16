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
end

