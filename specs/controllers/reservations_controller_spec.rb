# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReservationsController, type: :controller do
  describe "POST #create" do
    let!(:book) { create(:book) }
    let!(:user) { create(:user) }

    context "when parameters are valid" do
      let(:reservation_params) do
        {
          reservation: {
            book_id: book.id,
            user_id: user.id,
            email: user.email
          }
        }
      end

      it "reserves the book" do
        is_expect do
          post :create, params: reservation_params
        end.to change(Reservation, :count).by(1)

        expect(flash[:notice]).to eq('Reservation created successfully.')
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:reservation_params) do
        {
          reservation: {
            book_id: book.id,
            email: user.email,
          }
        }
      end

      it "does not reserve the book" do
        is_expect do
          post :create, params: reservation_params
        end.not_to change(Reservation, :count).by(1)

        expect(flash[:alert]).to match(/User must be present/)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user email does not match the reservation one" do
      let(:reservation_params) do
        {
          reservation: {
            book_id: book.id,
            user_id: user.id,
            email: "#{user.email}.invalid",
          }
        }
      end

      it "does not reserve the book" do
        is_expect do
          post :create, params: reservation_params
        end.not_to change(Reservation, :count).by(1)

        expect(flash[:alert]).to match(/does not match the user's email/)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
