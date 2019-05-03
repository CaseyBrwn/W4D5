# FactoryBot.define do 
#     factory :user do 
#         name {Faker::Movies::StarWars.character}
#         password {'starwars'}
#     end
# end



FactoryBot.define do
  factory :user do
    username { Faker::Movies::StarWars.character } 
    password { "starwars" }
  end
end