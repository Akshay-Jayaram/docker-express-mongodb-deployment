source .env.db #db details
source .env.network #network details

MONGODB_IMAGE="mongodb/mongodb-enterprise-server"
MONGODB_IMAGE_TAG="8.0-ubuntu2204"

PORT="27017"
VOLUME_NAME="key-value-vol"

#root user
ROOT_USER="root-user"
ROOT_PASSWORD="root-password"


#check if the network already exixts; else create one
if [ "$(docker network ls -q -f name=$NETWORK_NAME)" ]; then
    echo "A network with the name $NETWORK_NAME already exists. Skipping network creation."
else
    docker network create $NETWORK_NAME
fi

#check if the container already exixts
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "A container with the name $CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker kill $CONTAINER_NAME"
    exit 1
fi

docker run -d --name $CONTAINER_NAME \
    -p $PORT:27017 \
    -e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
    -e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
    -e KEY_VALUE_DB=$KEY_VALUE_DB \
    -e KEY_VALUE_USERNAME=$KEY_VALUE_USERNAME \
    -e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
    -v $VOLUME_NAME:/data/db \
    -v ./db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js \
    --network $NETWORK_NAME \
    $MONGODB_IMAGE:$MONGODB_IMAGE_TAG