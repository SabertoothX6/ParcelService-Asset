Deploy=`cat status`
if [ "$Deploy" = "green" ]
then
	echo "Switching to blue"
	#remove old container
	docker rm -f proxyblue
	docker rm -f restblue1
	docker rm -f restblue2
	#pull latest image from asset-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start latest image as restblue
	docker run -d --restart always --network=ParcelService --name=restblue1 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	docker run -d --restart always --network=ParcelService --name=restblue2 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker run -d -p 8443:8443 -e STATE=proxyblue --restart always --network=ParcelService --name=proxy asset.allgaeu-parcel-service.de:5000/parcelservice-proxy
	echo "blue" > status
else
	echo "Switching to green"
	#remove old container
	docker rm -f proxygreen
	docker rm -f restgreen1
	docker rm -f restgreen2
	#pull latest image from asser-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start �latest image as restgreen
	docker run -d --restart always --network=ParcelService --name=restgreen1 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	docker run -d --restart always --network=ParcelService --name=restgreen2 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker run -d -p 8443:8443 -e STATE=proxygreen --restart always --network=ParcelService --name=proxy asset.allgaeu-parcel-service.de:5000/parcelservice-proxy
	echo "green" > status
fi
