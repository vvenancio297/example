# Book Reservation System

This Rails application provides a feature for reserving books by users. It includes models for `Book`, `User`, and `Reservation`, and exposes an endpoint to reserve a book. The system ensures that only available books can be reserved, and that reservations are tied to a user's email.

## Features

- **Book Reservation:** Users can reserve available books.
- **Status Management:** Book status changes to `reserved` upon reservation.
- **Validation:** Prevents reservation if the book is already reserved or checked out.
- **Email Verification:** Reservation email must match the user's email.
- **Edge Case Handling:** Handles duplicate reservations and invalid requests.
- **API Response:** JSON responses for reservation requests.
- **Unit Tests:** RSpec tests for reservation scenarios.

## API Endpoints

### Reserve a Book

**POST** `/books/:id/reserve`

#### Parameters

- `reservation[user_id]` (integer, required): ID of the user making the reservation.
- `reservation[user_email]` (string, required): Email of the user making the reservation.

#### Example Request

```json
POST /books/1/reserve
{
  "reservation": {
    "user_id": 42,
    "user_email": "user@example.com"
  }
}
```

#### Example Response

- **Success (201 Created):**
  ```json
  {
    "id": 1,
    "book_id": 1,
    "user_id": 42,
    "user_email": "user@example.com",
    "reserved_at": "2025-11-13T23:59:59Z",
    "expires_at": "2025-11-27T23:59:59Z",
    ...
  }
  ```

- **Failure (422 Unprocessable Entity):**
  ```json
  {
    "errors": [
      "Book is not available for reservation"
    ]
  }
  ```

## Models

### Book

- `title`: string
- `author`: string
- `status`: string (`available`, `reserved`, `checked_out`)

### User

- `name`: string
- `email`: string

### Reservation

- `book_id`: references Book
- `user_id`: references User
- `user_email`: string
- `reserved_at`: datetime
- `expires_at`: datetime

## Validations & Business Logic

- Book must be `available` to be reserved.
- Reservation email must match the user's email.
- Duplicate reservations by the same user for the same book are not allowed.
- Book status is updated to `reserved` upon successful reservation.

## Running Tests

RSpec is used for testing. To run the tests:

```sh
bundle exec rspec
```

## Setup

1. Install dependencies:
   ```sh
   bundle install
   ```
2. Setup the database:
   ```sh
   rails db:create db:migrate
   ```
3. Run the server:
   ```sh
   rails server
   ```

## License

MIT
