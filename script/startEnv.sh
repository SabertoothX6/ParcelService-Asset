docker stop db
docker stop rest1
docker stop rest2
docker stop proxy
docker stop webserver
docker rm -f db
docker rm -f rest1
docker rm -f rest2
docker rm -f proxy
docker rm -f webserver
docker rmi -f asset.allgaeu-parcel-service.de:5000/parcelservice-database
docker rmi -f asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker rmi -f asset.allgaeu-parcel-service.de:5000/parcelservice-proxy
docker rmi -f asset.allgaeu-parcel-service.de:5000/parcelservice-webserver

docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-database
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-frontend
docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-proxy

docker run -d --restart always --network=ParcelService --name=db asset.allgaeu-parcel-service.de:5000/parcelservice-database
docker run -d --restart always --network=ParcelService --name=restgreen asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker run -d --restart always --network=ParcelService --name=restblue asset.allgaeu-parcel-service.de:5000/parcelservice-server
docker run -d -p 80:80 --restart always --network=ParcelService --name=webserver asset.allgaeu-parcel-service.de:5000/parcelservice-frontend
docker run -d -p 8443:8443 --restart always --network=ParcelService --name=proxy asset.allgaeu-parcel-service.de:5000/parcelservice-proxy

