FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    first_name { Gimei.first.kanji }
    last_name { Gimei.last.kanji }
    first_name_reading { Gimei.first.katakana }
    last_name_reading { Gimei.last.katakana }
    birthday {Faker::Date.birthday}
    email {Faker::Internet.free_email}
    password {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end