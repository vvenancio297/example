# frozen_string_literal: true

class Book < ApplicationRecord
  validates :name, presence: true

  has_many :reservations, dependent: :destroy
end
