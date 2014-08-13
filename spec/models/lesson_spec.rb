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

  describe "new lesson" do
    before do
      @new_lesson = Lesson.new(name: "new", description: "desc", 
        subject_id: 1)
      @new_lesson.save

    end

    it "should have example video" do
      expect(@new_lesson.videos.count).to eq 1
    end

    describe "after adding first new video" do
      before do
        @video1 = @new_lesson.videos.create(name: "video", 
          link: "youtube.com/watch?v=test")       
      end

      it "example video should be destroyed" do
        expect(@new_lesson.videos.count).to eq 1
        expect(@new_lesson.videos).to include @video1
      end

      describe "adding second video" do
        before do
          @video2 = @new_lesson.videos.create(name: "video 2",
            link: "youtube.com/watch?v=test2")
        end

        it "should not destroy first video" do
          expect(@new_lesson.videos.count).to eq 2
          expect(@new_lesson.videos).to include @video1, @video2
        end
      end
    end
  end
end
