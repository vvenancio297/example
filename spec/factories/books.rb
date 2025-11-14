# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { "The Great Gatsby" }
    status { "available" }
    author { "F. Scott Fitzgerald" }
  end
end
