Fabricator(:review) do
  body { Faker::Lorem.paragraphs(2)}
  rating { 3 }
  video_id { Fabricate(:video).id}
  user_id { Fabricate(:user).id}
end