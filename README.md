# Restaurant Menu API

This project provides an API for managing restaurant menus, including restaurants, menus, and menu items. It also includes a JSON import feature to populate the database with structured restaurant data.

## Requirements

- Docker
- Docker Compose

## Setup and Running the Project

1. Clone the repository:
   ```sh
   git clone <repository_url>
   cd <project_directory>
   ```
2. Start the application using Docker Compose:
   ```sh
   docker compose up --build
   ```
3. The application should now be running and accessible at `http://localhost:3000`.

## Running the JSON Import Task

To import restaurant data from a JSON file, use the following command inside the running Docker container:

```sh
docker compose exec rails rails json:import FILE=restaurant_data.json
```

Ensure that `restaurant_data.json` is in the root directory of the Rails application.

## API Collection

For testing the API, a Postman collection is available:

[Postman Collection
](https://www.postman.com/lunar-module-technologist-86861193/restaurant-menu-api/collection/ykhtfpr/restaurant-api?action=share&creator=26121913)

## Next Steps

- Develop a frontend application to interact with the API.
- Implement security measures and input validation.
- Add authentication and authorization for secure API access.
