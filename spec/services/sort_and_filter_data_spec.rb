require 'rails_helper'

describe Admin::SortAndFilterData do

  before do
    @user1 = User.create!(email: "a@a.com", 
                          password: "foobar123",
                          password_confirmation: "foobar123")
    @user2 = User.create!(email: "b@b.com", 
                          password: "foobar123",
                          password_confirmation: "foobar123")

    @user1.save
    @user2.save


  end

  describe "sorting in ascending order" do

    params = {}
    params[:sort] = "email"
    params[:direction] = "asc"

    it "should return sorted data" do
      expect(Admin::SortAndFilterData.call(User, params)).
        to eq [@user1, @user2]
    end
  end

  describe "sorting in descending order" do

    params = {}
    params[:sort] = "email"
    params[:direction] = "desc"

    it "should return sorted data" do
      expect(Admin::SortAndFilterData.call(User, params)).
        to eq [@user2, @user1]
    end
  end
end
