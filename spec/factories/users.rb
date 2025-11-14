# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "#{name.downcase.gsub(' ', '_')}@example.com" }
  end
end
