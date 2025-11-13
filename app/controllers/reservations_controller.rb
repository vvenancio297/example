# frozen_string_literal: true

class ReservationsController < ApplicationController
  def create
    reservation = Reservation.new(reservation_params)

    if reservation.save
      redirect_to root_path, notice: 'Reservation created successfully.'
    else
      redirect_to root_path, alert: reservation.errors.full_messages.to_sentence
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:book_id, :user_id, :email)
  end
end
