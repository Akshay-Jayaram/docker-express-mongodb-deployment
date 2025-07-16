# 1. Stop and remove mongodb containers
# 2. Stop and remove app containers
# 4. Remove networks

source .env.db
source .env.network

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Removing DB container $CONTAINER_NAME"
    docker stop $CONTAINER_NAME 
    docker rm $CONTAINER_NAME 
else
    echo "A container with the name $CONTAINER_NAME does not exist. Skipping container deletion."
fi


if [ "$(docker network ls -q -f name=$NETWORK_NAME)" ]; then
    echo "Removing network $NETWORK_NAME"
    docker network rm $NETWORK_NAME
else
    echo "A network with the name $NETWORK_NAME does not exist. Skipping network deletion."
fi