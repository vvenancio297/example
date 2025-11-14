# frozen_string_literal: true

require "rails_helper"

RSpec.describe BooksController, type: :controller do
  describe "POST #reserve" do
    let!(:book) { create(:book) }
    let!(:user) { create(:user) }

    context "when parameters are valid" do
      let(:reservation_params) do
        {
          reservation: {
            user_id: user.id,
            user_email: user.email
          },
          id: book.id
        }
      end

      it "reserves the book" do
        expect do
          post :reserve, params: reservation_params
        end.to change { Reservation.count }.by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:reservation_params) do
        {
          reservation: {
            user_email: user.email,
          },
          id: book.id
        }
      end

      it "does not reserve the book" do
        expect do
          post :reserve, params: reservation_params
        end.to change(Reservation, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user email does not match the reservation one" do
      let(:reservation_params) do
        {
          reservation: {
            user_id: user.id,
            user_email: "#{user.email}.invalid",
          },
          id: book.id
        }
      end

      it "does not reserve the book" do
        expect do
          post :reserve, params: reservation_params
        end.to change(Reservation, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
