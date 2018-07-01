Deploy=`cat status`
if [ "$Deploy" = "green" ]
then
	echo "Switching to blue"
	#remove old container
	docker rm -f restblue
	#pull latest image from asset-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start latest image as restblue
	docker run -d --restart always --network=ParcelService --name=restblue asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker exec -d proxy sh "haproxy -d -f /usr/local/etc/haproxy/proxyblue.cfg"
	echo "blue" > status
else
	echo "Switching to green"
	#remove old container
	docker rm -f restgreen
	#pull latest image from asser-server
	docker pull asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#start Ãlatest image as restgreen
	docker run -d --restart always --network=ParcelService --name=restgreen asset.allgaeu-parcel-service.de:5000/parcelservice-server
	#Switch haproxy.cfg
	docker exec -d proxy sh "haproxy -d -f /usr/local/etc/haproxy/proxyblue.cfg"
	echo "green" > status
fi
