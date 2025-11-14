# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :reserved_at, presence: true
  validates :expires_at, presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  validate :user_email_mismatch
  validate :book_available

  before_validation :set_reservation_date
  before_validation :set_expiration_date
  after_create :mark_book_as_reserved

  private

  def set_reservation_date
    self.reserved_at = Time.current
  end

  def set_expiration_date
    self.expires_at = 2.weeks.from_now
  end

  def mark_book_as_reserved
    book.update!(status: "reserved")
  end

  def user_email_mismatch
    errors.add(:user, "Can't be null") and return if user.blank?

    return if user_email == user.email

    errors.add(:user_email, "does not match the user's email")
  end

  def book_available
    if book.status == 'reserved' || book.status == 'checked_out'
      errors.add(:book, 'is not available for reservation')
    end
  end
end
