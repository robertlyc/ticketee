FactoryGirl.define do
  factory :user do
    name "Example name"
    email "abc@example.com"
    password "password"
    password_confirmation "password"
  end
end