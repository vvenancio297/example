# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validate :user_email_mismatch

  before_create :set_reservation_date
  before_create :set_expiration_date
  before_create :change_status_to_reserved

  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  private

  def set_reservation_date
    self.reserved_at = Time.current
  end

  def set_expiration_date
    self.expires_at = 2.weeks.from_now
  end

  def change_status_to_reserved
    self.status = "reserved"
  end

  def user_email_mismatch
    return if email == user.email

    errors.add(:email, "does not match the user's email")
  end
end
