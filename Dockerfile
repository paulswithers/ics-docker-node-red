FROM nodered/node-red-docker:v10

USER root
ENV DIRPATH /usr/src/node-red
WORKDIR $DIRPATH

COPY domino-domino-db-1.2.0.tgz .
RUN chmod 775 domino-domino-db-1.2.0.tgz
RUN chmod 775 /usr/src/node-red
RUN chmod 775 /usr/local/lib
RUN npm install --save axios
RUN	npm install --save domino-domino-db-1.2.0.tgz
RUN	npm install --save node-red-contrib-dominodb
RUN	npm install --save node-red-contrib-ibmconnections
RUN npm install --save node-red-contrib-fullsplitter
RUN npm install --save node-red-contrib-bigsplitter
RUN npm install --save node-red-contrib-excel
RUN npm install --save node-red-contrib-fs-ops
RUN npm install --save node-red-contrib-iss-location
RUN npm install --save node-red-contrib-wait-paths
RUN npm install --save node-red-contrib-web-worldmap
RUN npm install --save node-red-dashboard
RUN npm install --save node-red-contrib-json2csv
	
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
COPY flows.json /data
RUN chmod 775 /data/flows.json