FactoryBot.define do
  factory :review do
    rating { 5 }
    comment { "Great!" }
    association :user
    association :book
  end
end

