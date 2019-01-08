FROM nodered/node-red-docker:v8

USER root
ENV DIRPATH /usr/src/node-red
WORKDIR $DIRPATH

COPY domino-domino-db-1.1.0.tgz .
RUN chmod 775 domino-domino-db-1.1.0.tgz
RUN npm install --save axios && \
	npm install --save domino-domino-db-1.1.0.tgz && \
	npm install --save node-red-contrib-dominodb && \
	npm install --save node-red-contrib-ibmconnections
	
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