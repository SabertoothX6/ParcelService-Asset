Deploy=`cat status`
if [ "$Deploy" = "green" ]
then
	echo "Switching to blue"
	#remove old container
	docker rm -f restblue1
	docker rm -f restblue2
	#pull latest image from asset-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start latest image as restblue
	docker run -d --restart always --network=ParcelService --name=restblue1 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	docker run -d --restart always --network=ParcelService --name=restblue2 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker exec -d proxy sh "haproxy -d -f /usr/local/etc/haproxy/proxyblue.cfg"
	echo "blue" > status
else
	echo "Switching to green"
	#remove old container
	docker rm -f restgreen1
	docker rm -f restgreen2
	#pull latest image from asser-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start �latest image as restgreen
	docker run -d --restart always --network=ParcelService --name=restgreen1 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	docker run -d --restart always --network=ParcelService --name=restgreen2 asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker exec -d proxy sh "haproxy -d -f /usr/local/etc/haproxy/proxygreen.cfg"
	echo "green" > status
fi
