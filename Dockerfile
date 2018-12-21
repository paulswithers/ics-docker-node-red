FROM nodered/node-red-docker:v8

ENV APP_DEV_PACK_LOC = COPY_APPDEVPACK_TAR_HERE/

WORKDIR /usr/src/node-red
USER root

COPY dominoTheme.css /data
RUN chmod 775 /data/dominoTheme.css
COPY dominoV10.png /data
RUN chmod 775 /data/dominoV10.png
COPY dominoAuthentication.js /data
RUN chmod 775 /data/dominoAuthentication.js
COPY dominoV10_large.jpg /data
RUN chmod 775 /data/dominoV10_large.jpg
COPY settings.js /data
RUN chmod 775 /data/settings.js

COPY domino-domino-db-1.0.0.tgz .

RUN tar -xf domino-domino-db-1.0.0.tgz && \
	npm install --save axios && \
	npm install --save package && \
	npm install --save node-red-contrib-dominodb && \
	npm install --save node-red-contrib-ibmconnections && \
	rm package -R