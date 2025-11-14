# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :status, presence: true, inclusion: { in: %w[available reserved checked_out] }

  has_many :reservations, dependent: :destroy

  before_create :set_default_status

  private

  def set_default_status
    self.status = "available"
  end
end
