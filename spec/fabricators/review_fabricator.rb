Fabricator(:review) do
  body { Faker::Lorem.paragraphs(2).join(" ")}
  rating { [1,2,3,4,5].sample }
  video_id { Fabricate(:video).id}
  user_id { Fabricate(:user).id}
  # video { Fabricate(:video)}
end