## NODE-RED DEMO FOR ICS

This is a demo Docker image customised for IBM Think 2019 demo:
- with DominoV10 look and feel
- installs domino-db npm package
- installs axios for authentication to Domino server
- installs Node-RED nodes for Domino
- installs Node-RED nodes for Connections

### IMPORTANT PREREQUISITE
1. Extract the downloaded App Dev Pack to a temporay location
2. Copy the domino-domino-db-1.1.0.tgz file from the extracted App Dev Pack into this folder
3. Change the hostname in the URL in line 17 of "dominoAuthentication.js"
4. Install Proton on your Domino server
5. Copy the node-demo.nsf into your Domino server, sign it and set Anonymous access to Editor
6. Start the proton task on your Domino server

### BUILDING THE IMAGE
1. Start Docker on your machine
2. Open a command line terminal
3. Change directories to this folder
4. Issue the command `docker build -t ibm-think/node-red-docker:v8 .` Remember the full stop at the end or it won't run.

### RUNNING A CONTAINER
From the open command line terminal, issue the command `docker run -it -p 1880:1880 ibm-think/node-red-docker:v8`

Or, if you're in Visual Studio Code with the Docker extension, just right-click the image in the Docker Explorer and choose "Run".

### TROUBLESHOOTING BUILDING THE IMAGE / CONTAINER
`unable to prepare context: unable to evaluate symlinks in Dockerfile path: GetFileAttributesEx C:\YOUR_PATH\Dockerfile: The system cannot find the file specified.`  
The build command looks for a file "Dockerfile" in the current folder. You're command line terminal isn't set to this folder. Change directories until your in this folder and run it again.

`Step 15/16 : COPY domino-domino-db-1.1.0.tgz .
COPY failed: stat /var/lib/docker/tmp/docker-builder027212245/domino-domino-db-1.1.0.tgz: no such file or directory`  
This means you forgot to copy in the domino-domino-db-1.1.0.tgz files from the App Dev Pack, or you're using something other than Domino 10.0.1.  
You will also have a broken docker image with name \<none>/\<none>. Issue the command `docker images`, copy the hex code for the docker image and issue the command `docker rmi ` + the docker image hex code you copied. This will remove the image.

`Login failed` with Valid Username and Password  
Make sure you changed the hostname in dominoAuthentication.js. If not, use `docker cp` to copy it out, edit it, copy it back and use `chmod 777` to re-set the file properties. Alternatively, delete the image, update dominoAuthentication.js in this folder and start again.

Container Starts But Cannot Connect  
Make sure you remembered to create the container with the port open (`-p 1880:1880`).

`Error response from daemon: driver failed programming external connectivity on endpoint cranky_chandrasekhar (8df2a3e18d5c29c4527ffa71e2bd30a4ed34e27ba895c20aa54015cea928610b): Bind for 0.0.0.0:1880 failed: port is already allocated.`  
Node-RED runs by default on Port 1880. Issue the Docker command to build the container manually, choosing a different port, e.g. `-p 8880:1880`. You will then be able to access Node-RED on "http://localhost:8880".