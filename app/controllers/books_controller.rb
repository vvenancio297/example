# frozen_string_literal: true

class BooksController < ApplicationController
  def reserve
    reservation = Reservation.new(reservation_params)
    reservation.book_id = params[:id]

    if reservation.save
      render json: reservation, status: :created
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :user_email)
  end
end
