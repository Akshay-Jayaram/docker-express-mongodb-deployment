# Dockerized Key-Value Backend Application (Without Docker Compose)

This project demonstrates how to deploy a simple **Express.js key-value backend application** along with its **MongoDB** database using **Docker containers**, managed via **shell scripts** without using Docker Compose. Each container runs independently but shares the same Docker network for communication.

---


## Application Overview

A basic key-value store built using **Express.js** and **MongoDB**.

### API Endpoints

- `POST /store`  
  Creates a new key-value pair  
  **Body:** `{ "key": "foo", "value": "bar" }`

- `GET /store/:key`  
  Retrieves the value for a given key

- `PUT /store/:key`  
  Updates the value of an existing key  
  **Body:** `{ "value": "new-bar" }`

- `DELETE /store/:key`  
  Deletes a key-value pair

---


### Starting the MongoDB Container


./start-db.sh

This script:\
	•	Creates a Docker network using the name from .env.network\
	•	Launches a MongoDB container using the configuration in .env.db\
	•	Initializes it with a database, username, and password via mongo-init.js in db-config/

### Starting the Backend Container

./start-backend.sh

This script:\
	•	Builds a Docker image for the Express.js backend from the backend/ folder\
	•	Runs a container connected to the same Docker network for communication with MongoDB

### Cleanup Resources

./cleanup.sh

This script stops and removes:\
	•	The MongoDB container\
	•	The custom Docker network

⸻

Notes\
	•	No Docker Compose is used in this project; everything is managed through shell scripts.\
	•	Ensure that your backend app reads MongoDB connection details (host, port, username, password, DB name) from environment variables passed in the script.\
	•	Both containers must belong to the same Docker network for the backend to connect to the database.


