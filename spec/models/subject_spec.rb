require 'rails_helper'

describe Subject do

	before do
		@subject = Subject.create(name: "subject", 
			description: "subject description")
	end

	subject { @subject }

	it { should respond_to :name }
	it { should respond_to :description }
	it { should respond_to :image_name }
	it { should respond_to :lessons }
	it { should respond_to :intro_video_link }
	it { should be_valid }

	describe "when name is blank" do
		before { @subject.name = " " }
		it { should_not be_valid }
	end

	describe "when description is blank" do
		before { @subject.description = " " }
		it { should_not be_valid }
	end

	describe "when image_name is blank" do
		before { @subject.image_name = " " }
		it { should be_valid }
	end


	describe "to_s method" do
		it "should return subject's name" do
			expect(@subject.to_s).to eq @subject.name
		end
	end

	describe "when intro_video_link is blank" do
		before { @subject.intro_video_link = " " }
		it { should be_valid }
	end

	describe "when intro_video_link hasn't got an id" do
		formats = %w[https://youtube.com youtube.com/test asdasd]
		formats.each do |format|
			before { @subject.intro_video_link = format }
			it { should_not be_valid }
		end
	end

	describe "when intro_video_link has the right format" do
		formats = %w[youtube.com/watch?v=f43dfaFd 
			https://youtube.com/watch?v=3453f]
			formats.each do |format|
				before { @subject.intro_video_link = format }
				it { should be_valid }
			end
		end

		describe "when intro_video_link has wrong format" do
			formats = %w[ youtube.com/watch?v=123das 
				youtube.com/watch?v=123&list=PL123 
				https://youtube.com/watch?v=123&index=1&list=1]

				formats.each do |format|
					before do
						@subject.intro_video_link = format
						@subject.save
					end

					it { should be_valid }
				end
			end
		end
