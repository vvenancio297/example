# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    book
    user
    email { user.email }
  end
end
