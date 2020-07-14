FactoryBot.define do
  
  factory :message do
    text              {"Faker::lorem.sentence"}
    image              {File.open("#{Rails.root}/public/images/4.jpg")}
    user
    group
  end

end

# deviseの設定は/spec/support/controller_masros.rbへ