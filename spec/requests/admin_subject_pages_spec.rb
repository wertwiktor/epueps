require 'rails_helper'

RSpec.describe "AdminSubjectPages", :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:subject1) { FactoryGirl.create(:subject) }
  let(:lesson1) { FactoryGirl.create(:lesson, subject: subject1) }

  describe "index page" do
    context "with no privileges" do
      before { visit admin_subject}
    end
  end
end
