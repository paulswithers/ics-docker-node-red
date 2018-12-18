FROM nodered/node-red-docker:v8

ENV APP_DEV_PACK_LOC = COPY_APPDEVPACK_TAR_HERE/
ENV NODE_RED_PROGRAM_DIR = /usr/src/node-red
ENV NODE_RED_DATA_INITIAL = ${NODE_RED_PROGRAM_DIR}/node_modules/node-red/red

COPY ${APP_DEV_PACK_TAR}/domino-domino-db-1.0.0.tgz ${NODE_RED_PROGRAM_DIR}/

USER root
RUN cd /usr/src/node-red && \
	tar -xf domino-domino-db-1.0.0.tgz && \
	npm install -g axios && \
	npm install -g package && \
	npm install -g node-red-contrib-dominodb && \
	npm install -g node-red-contrib-ibmconnections && \
	rm package -R && \
	cd node_modules/node-red/red && \
	mkdir images && \
	mkdir css

COPY dominoTheme.css ${NODE_RED_DATA_INITIAL}/css
COPY dominoV10.png ${NODE_RED_DATA_INITIAL}/images
COPY dominoAuthentication.js ${NODE_RED_DATA_INITIAL}
COPY settings.js ${NODE_RED_DATA_INITIAL}