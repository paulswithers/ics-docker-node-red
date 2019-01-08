## NODE-RED DEMO FOR ICS

This is a demo Docker image customised for Domino V10:
- with DominoV10 look and feel
- installs domino-db npm package
- installs axios for authentication to Domino server
- installs Node-RED nodes for Domino
- installs Node-RED nodes for Connections
- assumes anonymous access via Node.JS to Domino (the nodes, as of beginning Jan 2019 do not use client certificate or IAM access)

### IMPORTANT PREREQUISITE
1. Extract the downloaded App Dev Pack to a temporay location
2. Copy the domino-domino-db-1.1.0.tgz file from the extracted App Dev Pack into this folder
3. Install Proton on your Domino server and configure, according to the documentation
4. Copy the node-demo.nsf into your Domino server, sign it and set Anonymous access to Editor
5. Start the proton task on your Domino server

This expects the GA release of the App Dev Pack from December 2018. It may not work with a different Proton version and different domino-domino-db version copied in.

### BUILDING THE IMAGE
1. Start Docker on your machine
2. Open a command line terminal
3. Change directories to this folder
4. Issue the command `docker build -t ics/node-red-docker:v8 .` Remember the full stop at the end or it won't run. It builds node-red and installs additional modules, then switches to copying files into the data folder. `tar -xf` extracts the zipfile fully, so all we have is the `package` folder.

### RUNNING A CONTAINER
From the open command line terminal, issue the command `docker run -it -p 1880:1880 -e "AUTHENTICATION_HOST=http://MY.HOST.COM" ics/node-red-docker:v8`. This will create a container letting Docker choose a name, accessible from localhost:1880 and authenticating against a Domino server via http at "MY.HOST.COM". To give it a specific name `docker run -it -p 1880:1880 -e "AUTHENTICATION_HOST=http://MY.HOST.COM" --name CONTAINER_NAME ics/node-red-docker:v8`

Or, if you're in Visual Studio Code with the Docker extension, just right-click the image in the Docker Explorer and choose "Run".

### TROUBLESHOOTING BUILDING THE IMAGE / CONTAINER
`unable to prepare context: unable to evaluate symlinks in Dockerfile path: GetFileAttributesEx C:\YOUR_PATH\Dockerfile: The system cannot find the file specified.`  
The build command looks for a file "Dockerfile" in the current folder. You're command line terminal isn't set to this folder. Change directories until your in this folder and run it again.

`Step 5/17 : COPY domino-domino-db-1.1.0.tgz .
COPY failed: stat /var/lib/docker/tmp/docker-builder027212245/domino-domino-db-1.1.0.tgz: no such file or directory`  
This means you forgot to copy in the domino-domino-db-1.1.0.tgz files from the App Dev Pack, or you're using something other than Domino 10.0.1.  
You will also have a broken docker image with name \<none>/\<none>. Issue the command `docker images`, copy the hex code for the docker image and issue the command `docker rmi ` + the docker image hex code you copied. This will remove the image.

`Login failed` with Valid Username and Password  
Make sure you changed the hostname in dominoAuthentication.js. If not, use `docker cp` to copy it out, edit it, copy it back and use `chmod 777` to re-set the file properties. Alternatively, delete the image, update dominoAuthentication.js in this folder and start again.

Container Starts But Cannot Connect  
Make sure you remembered to create the container with the port open (`-p 1880:1880`).

`Error response from daemon: driver failed programming external connectivity on endpoint cranky_chandrasekhar (8df2a3e18d5c29c4527ffa71e2bd30a4ed34e27ba895c20aa54015cea928610b): Bind for 0.0.0.0:1880 failed: port is already allocated.`  
Node-RED runs by default on Port 1880. Issue the Docker command to build the container manually, choosing a different port, e.g. `-p 8880:1880`. You will then be able to access Node-RED on "http://localhost:8880".

### CONNECTING TO DOMINO
For a Docker container "localhost" is the container itself, not the host PC Docker is installed on. If you need to connect to a locally installed Domino server, I would recommend using something like ngrok that can give it an externally accessible hostname.

Similarly, I wouldn't expect Docker to be able to connect to a server that's not accessible to the outside world. Your own PC will be looking up to something somewhere that tells it the IP address that corresponds to the fully qualified server host name. The Docker container probably won't know to look to that. You will need to speak to your networking expert to find out how to tell a Linux image where to find a specific host name.

The recommended approach is connecting to a Domino Docker container installed in the same Docker installation as this Node-RED container. But you will need to create a Docker bridge network that they are both on. Then you can connect to the server using the Docker container name.

Create a bridge network using `docker network create NET_NAME`.

`docker network connect NET_NAME CONTAINER_NAME` connects a running container to a network. The container must already be running. If it's stopped and restarted, the container remains connected to the network. Connect Domino to that network, then Node-RED. You'll then be able to connect to the server using the relevant container name. If you've let Docker choose it's own name, the container will have a name like "peaceful_germain"