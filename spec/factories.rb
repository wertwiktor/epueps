FactoryGirl.define do
  factory :subject do
    name          "Subject"
    image_name    "subject.jpg"
    description   "Lorem ipsum"
    popularity    0
  end

  factory :lesson do
    name          "Lesson"
    video_link    "youtube.com/watch?v=sr3kd3"
    description   "Lorem ipsum"       
  end
end