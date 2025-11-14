class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :reservations do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :user_email, null: false
      t.datetime :reserved_at, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
