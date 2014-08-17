require 'rails_helper'

RSpec.describe User, :type => :model do

  before do
    @user = User.new(email: "foo@bar.com", password: "foobar123")
    @user.save
  end

  subject { @user }

  describe "when email is blank" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is blank" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "admin? method" do
    describe "for non-admin users" do
      it "should be false" do
        expect(@user.admin?).not_to eq true
      end
    end

    describe "for admin users" do
      before { @user.admin = true }
      it "should be true" do
        expect(@user.admin?).to eq true
      end
    end
  end

  describe "when email is already in database" do
    before do
      @user2 = User.new(email: "foo@bar.com", password: "foobar123")
      @user2.save
    end

    subject { @user2 }
    it { should_not be_valid }
  end

end
