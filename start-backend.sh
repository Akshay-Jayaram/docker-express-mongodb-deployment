source .env.db #db details
source .env.network #network details

PORT="3000"

BACKEND_IMAGE_NAME=key-value-backend
BACKEND_CONTAINER_NAME=backend

MONGODB_HOST=mongodb


#check if the container already exixts
if [ "$(docker ps -q -f name=$BACKEND_CONTAINER_NAME)" ]; then
    echo "A container with the name $BACKEND_CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker kill $BACKEND_CONTAINER_NAME"
    exit 1
fi

docker build -t $BACKEND_IMAGE_NAME \
    -f backend/Dockerfile \
    backend

docker run -d --name $BACKEND_CONTAINER_NAME \
    -p $PORT:3000 \
    -e KEY_VALUE_DB=$KEY_VALUE_DB \
    -e KEY_VALUE_USERNAME=$KEY_VALUE_USERNAME \
    -e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
    -e MONGODB_HOST=$MONGODB_HOST \
    --network $NETWORK_NAME \
    $BACKEND_IMAGE_NAME