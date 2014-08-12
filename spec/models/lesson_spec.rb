require 'rails_helper'

describe Lesson do
  before do
  	@subject = Subject.create(
      name: "subject", 
      description: "subject description")
  	@lesson = @subject.lessons.create(
      name: "lesson", 
      description: "lesson description")
    @video = @lesson.videos.create(
      link: "https://www.youtube.com/watch?v=5ca8p5OWniI",
      name: "Wykład")
  end

  subject { @lesson }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :subject_id }
  it { should respond_to :videos }	

  it { should be_valid }
  
  describe "when subject_id is not present" do
  	before { @lesson.subject_id = nil }
  	it { should_not be_valid }
  end

  describe "when name is blank" do
  	before { @lesson.name = " " }
  	it { should_not be_valid }
  end

  describe "when description is blank" do
  	before { @lesson.description = " " }
  	it { should_not be_valid }
  end

  describe "deleting lesson" do
    before { @lesson.destroy! }

    it "should delete its videos" do
      expect(Video.where(id: @video.id)).to be_empty
    end
  end
end
