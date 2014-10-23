Fabricator(:invitation) do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  message { Faker::Lorem.words(10).join(" ") }
  sender_id { Fabricate(:user).id }
end