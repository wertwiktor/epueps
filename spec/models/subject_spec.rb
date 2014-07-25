require 'spec_helper'

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


end
