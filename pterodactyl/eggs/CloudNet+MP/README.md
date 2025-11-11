# [Cloud Net](https://github.com/CloudNetService/CloudNet)
A modern application that can dynamically and easily deliver Minecraft oriented software
- Its Really Important to use Version 4.0.0-RC11 or newer because it implements a [fixed version of jline](https://github.com/CloudNetService/CloudNet/pull/1441)
- Get newest Release on [CloudNet github](https://github.com/CloudNetService/CloudNet/releases)

# [MultiPaper](https://multipaper.io/)
Run a single world across multiple Minecraft servers.
Fork of Purpur with optimisations from Airplane and Pufferfish, giving you the best possible performance.

> [!IMPORTANT] 
> MultiPaper is in Public Beta!
> Bugs are infrequent, and may only occur for a few players on your server, however they still exist and can range from duping items to corrupted chunks, but are very unlikely.

# Installation
1. Go to your Pterodactyl Admin Panel
2. Navigate to Nests and create a new Nest
3. Go back to nests and Import an Egg
4. Insert your [downloaded egg file](https://github.com/Lostes-Burger/Docker/blob/main/pterodactyl/eggs/CloudNet%2BMP/egg-CloudNetV4-MultiPaper.json)
5. Now create a new Server. You need to provide an url each for the MultiPaper master and server. Copy url for newest version [here](https://multipaper.io/download.html)
6. Select how many MultiPaper servers should be created in the installation and how much ram you want for each.

### Hardware
To even justify running a MultiPaper server Network, you need at least 10-15 player generating new chunkes per instance. I recommend 4-5 GB ram & 4 vCores for each instance
- Minimal requirement (2 Instances + proxy & no lobby): 8GB RAM + 6 vCores
- The first start of MultiPaper is really recource intensive. I recommend starting and setting all plugins up with 2 instances. You can set the service count later using this command: `tasks task Server set minServiceCount {count}`
- Diffrent than normal minecraft servers it's not really important to have a CPU with strong single core performance (clock speed). MultiPaper uses many servers so you need a high core cpu for running a Network. (Only if you are expecting 1000 players on the Map, if you expect about 100 players this doesn't really matter.)

### Wings Settings (important)
CloudNet Networks like a MultiPaper configuration: increase `container_pid_limit` in the `/etc/pterodactyl/config.yml` file to more than 512 for example 3512. Don't foget to restart wings `service wings restart`\
For more information: [pterodactyl wings configuration](https://pterodactyl.io/wings/1.0/configuration.html#container-pid-limit)
- 4 Processes are 512 pid (not multi threaded)
- The bigger the network, the more pid's you need. In our case, we use MultiPaper. It's important to set this value high (`3512`) to prevent the `OS Error: Out of Memory` error, despite of having Memory left.

# Setup CloudNet
> [!CAUTION]
> Due to the default CloudNet setup being skipped by installing MultiPaper.
> Use [this setup guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#setup-cloudnet)

# Important
> [!CAUTION]
> Your probably can't connect to your server due to missing CloudNet modules (a missing fallback configuration) and the Proxy port not being correct. This can be fixed quite easy with the guides below.
>
> If you used the default CloudNet setup (not the version provided above), set the correct Port of your Proxy and allow players to join using the [Correct-Port guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/CloudNet%2BMP#correct-port)
> 
> Follow the [Missing-Modules-Fallback guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/CloudNet%2BMP#missing-modules-fallback) to install the missing modules and set a fallback configuration.

> [!WARNING]
> If you use the "tasks setup" command in the pterodactyl sometimes your input isn't recived properly, causing wierd memory configurations
> For example if you input the memory in the setup process cloudnet will think you set the memory to 512+your selected memory
> In most cases this overfloods the max memory set in the launcher configuration causing an error. To fix this follow the [Wrong-Input guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/CloudNet%2BMP#wrong-input)
  
# Wrong-Input
* Even if CloudNet works with Pterodactly using this egg, not all features are fully working. For example the "tasks setup" command, the inputs are not allways detected correctly. If you input the memory CloudNet will create the configuration with 512+memory MB. To fix this use the command below. Replace the Placeholders {task-name} (The Name of your task, you want to change) and {memory} (with the selected memory in MB)
1. `tasks task {task-name} set maxHeapMemory {memory}`

# Missing-Modules-Fallback
* In CloudNet V4 the default Modules are not installed correctly or are missing, they need to be installed and configures correctly. Follow the guide below to install the Correct Modules and add a Fallback task.
1. You need the CloudNet-Bridge and theCloudNet-SyncProxy module install them with "modules install CloudNet-Bridge" and "modules install CloudNet-SyncProxy"
2. Navigate in the folder /modules/CloudNet-Bridge/config.json and set the Fallback task name. For example: `"defaultFallbackTask": "Lobby"`

# Correct-Port
* This is only important for you if you've setup CloudNet via the internal Setup and didn't created the Tasks manually. CloudNet doesn't know the correct port for your Proxy to start. The default port 25565 is set, which in most cases, when using pterodactyl is already in use.
* To set the correct Proxy port use the command below and replace the Placeholders {task-name} (The Name of your Proxy task, the default is "Proxy") and the Port {port} (its important you set the port of your Pterodactyl container which you use to join with your Minecraft client, you see this port behind the ip or domain in you server panel for example myhostdomain.de:25001, the port is 25001.)
1. `tasks task {task-name} set startPort {port}`