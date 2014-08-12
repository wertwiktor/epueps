require 'rails_helper'

RSpec.describe Video, :type => :model do
  before do
    @video = Video.create(
      name: "Video",
      link: "https://www.youtube.com/watch?v=5ca8p5OWniI")
    @video.save
  end

  subject { @video }

  it { should respond_to :name }
  it { should respond_to :link }
  it { should respond_to :lesson_id }

  it { should be_valid }

  describe "when name is blank" do
    before { @video.name = " " }
    it { should_not be_valid }
  end

  describe "when link is blank" do
    before { @video.link = " " } 
    it { should_not be_valid }
  end

  describe "when link has wrong format" do
    formats = %w[ youtube.com/watch?v=123das 
                  youtube.com/watch?v=123&list=PL123 
                  https://youtube.com/watch?v=123&index=1&list=1]

    formats.each do |format|
      before do
        @video.link = format
        @video.save
      end

      it { should be_valid }
    end
  end

  describe "when link hasn't got an id" do
    formats = %w[https://youtube.com youtube.com/test]
    formats.each do |format|
      before { @video.link = format }
      it { should_not be_valid }
    end
  end

  describe "when link has the right format" do
    formats = %w[youtube.com/watch?v=f43dfaFd https://youtube.com/watch?v=3453f]
    formats.each do |format|
      before { @video.link = format }
      it { should be_valid }
    end
  end
end
