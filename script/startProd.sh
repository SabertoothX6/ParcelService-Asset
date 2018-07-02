docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-database
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-frontend
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-proxy

docker run -d --restart always --network=ParcelService --name=db asset.allgaeu-parcel-service.de:5000/parcelservice-database
docker run -d --restart always --network=ParcelService --name=restgreen1 asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker run -d --restart always --network=ParcelService --name=restgreen2 asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker run -d -p 80:80 --restart always --network=ParcelService --name=webserver asset.allgaeu-parcel-service.de:5000/parcelservice-frontend
docker run -d -p 8443:8443 --restart always --network=ParcelService --name=proxy asset.allgaeu-parcel-service.de:5000/parcelservice-proxy

docker exec -d proxy sh "haproxy -d -f /usr/local/etc/haproxy/proxygreen.cfg"

echo "green" > status
