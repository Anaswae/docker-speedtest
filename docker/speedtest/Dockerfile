FROM node:8
MAINTAINER Jonas Friedmann <j@frd.mn>

WORKDIR /usr/src/app

ENV INFLUXDB_DB="speedtest" \
    INFLUXDB_URL="http://influxdb:8086" \
    SPEEDTEST_HOST="local" \
    SPEEDTEST_INTERVAL=3600

COPY . .

RUN npm install -g git://github.com/Tigger2014/speed-test.git json

CMD [ "npm", "start" ]
