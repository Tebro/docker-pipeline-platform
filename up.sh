docker-machine create -d virtualbox infra


export INFRA_IP=$(docker-machine ip infra)

echo "Infra IP is: $INFRA_IP"

echo "Point Docker client to Infra server"

eval $(docker-machine env infra)

echo "Start Rancher"

docker run -d --name rancher --restart=always -p 8080:8080 rancher/server


echo "Start Gogs and Drone"
docker-compose -f gogs-drone.yml up -d

echo "Creating Compute Node"

# Creating one node machine
docker-machine create -d virtualbox node

echo "Configuring Gogs"

curl -X POST -d "db_type=SQLite3&db_path=/data/gogs.db&app_name=Gogs&repo_root_path=/data/git/gogs-repositories&run_user=git&domain=$INFRA_IP&ssh_port=2222&http_port=3000&app_url=http://$INFRA_IP:3000/&log_root_path=/data/gogs/log" http://$INFRA_IP:3000/install


echo "Access Rancher on: http://$INFRA_IP:8080"
echo "Access Gogs on: http://$INFRA_IP:3000"
echo "Access Gogs(SSH) on: http://$INFRA_IP:2222"
echo "Access Drone on: http://$INFRA_IP:8000"

echo ""
echo "Continue reading the README.md file for directions on how to add the node to rancher"
