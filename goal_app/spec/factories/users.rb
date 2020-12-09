FactoryBot.define do
  factory :user do
    username { Faker::Movies::LordOfTheRings.character } # a block will execute each time a user is created with the factory
      password { "onering" }
  end
end
