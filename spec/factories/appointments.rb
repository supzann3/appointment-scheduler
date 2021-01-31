FactoryBot.define do
  factory :appointment do
    user_id 1
    time '12:30'
    date (Time.now + 2.days).strftime("%F")
  end
end
