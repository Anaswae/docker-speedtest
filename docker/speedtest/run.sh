#!/bin/bash

while :; do
	echo "[Info][$(date)] Starting speedtest... to closest server"
	JSON=$(speed-test -j -v)
	DOWNLOAD=$(echo "${JSON}" | json download)
	UPLOAD=$(echo "$JSON" | json upload)
	PING=$(echo "${JSON}" | json ping)
	HOST=$(echo "${JSON}" | json data | json server | json host)
	echo "[Info][$(date)] Speedtest results - Download: ${DOWNLOAD}, Upload: ${UPLOAD}, Ping: ${PING}, Host: ${HOST}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "download,host=${HOST} value=${DOWNLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "upload,host=${HOST} value=${UPLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "ping,host=${HOST} value=${PING}"
	echo "sleeping before next test"
	sleep 10
	echo "[Info][$(date)] Starting speedtest... to CFL"
	JSON=$(speed-test -j -v -s CFL)
	DOWNLOAD=$(echo "${JSON}" | json download)
	UPLOAD=$(echo "$JSON" | json upload)
	PING=$(echo "${JSON}" | json ping)
	HOST=$(echo "${JSON}" | json data | json server | json host)
	echo "[Info][$(date)] Speedtest results - Download: ${DOWNLOAD}, Upload: ${UPLOAD}, Ping: ${PING}, Host: ${HOST}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "download,host=${HOST} value=${DOWNLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "upload,host=${HOST} value=${UPLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "ping,host=${HOST} value=${PING}"
	echo "sleeping before next test"
	sleep 10
	echo "[Info][$(date)] Starting speedtest... to Wimbledon"
	JSON=$(speed-test -j -v -s Wimbledon)
	DOWNLOAD=$(echo "${JSON}" | json download)
	UPLOAD=$(echo "$JSON" | json upload)
	PING=$(echo "${JSON}" | json ping)
	HOST=$(echo "${JSON}" | json data | json server | json host)
	echo "[Info][$(date)] Speedtest results - Download: ${DOWNLOAD}, Upload: ${UPLOAD}, Ping: ${PING}, Host: ${HOST}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "download,host=${HOST} value=${DOWNLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "upload,host=${HOST} value=${UPLOAD}"
	curl -sL -XPOST "${INFLUXDB_URL}/write?db=${INFLUXDB_DB}" --data-binary "ping,host=${HOST} value=${PING}"
	echo "[Info][$(date)] Sleeping for ${SPEEDTEST_INTERVAL} seconds..."
	sleep ${SPEEDTEST_INTERVAL}
	echo "sleeping before second test"
done
