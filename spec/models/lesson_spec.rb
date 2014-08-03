require 'rails_helper'

describe Lesson do
  before do
  	@subject = Subject.create(	name: "subject", 
  													description: "subject description")
  	@lesson = @subject.lessons.create(name: "lesson", 
  																		description: "lesson description",
  				video_link: "https://www.youtube.com/watch?v=5ca8p5OWniI")
  end

  subject { @lesson }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :subject_id }
  it { should respond_to :video_link }	

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

  describe "when video_link is blank" do
  	before { @lesson.video_link = " " } 
  	it { should_not be_valid }
  end

  describe "when video_link has wrong format" do
  	formats = %w[https://youtube.com youtube.com?v=f3fas3&list=3f3f]
  	formats.each do |format|
  		before { @lesson.video_link = format }
  		it { should_not be_valid }
  	end
  end

  describe "when video_link has the right format" do
  	formats = %w[youtube.com/watch?v=f43dfaFd https://youtube.com/watch?v=3453f]
  	formats.each do |format|
  		before { @lesson.video_link = format }
  		it { should be_valid }
  	end
  end
end
