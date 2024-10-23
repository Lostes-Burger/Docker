# [Cloud Net](https://github.com/CloudNetService/CloudNet)
A modern application that can dynamically and easily deliver Minecraft oriented software

# [Cloud Net V4](https://github.com/CloudNetService/CloudNet/releases)

This Egg only supports CloudNet V4 a experimental version of cloudnet.
I reccomend the generall usage of the new version due to newer implementations and features

> [!IMPORTANT] 
> Its Really Important to use Version 4.0.0-RC11 because it implements a [fixed version of jline](https://github.com/CloudNetService/CloudNet/pull/1441)
> 
> I only created this egg and tutorial, I am not able to be held responsible if anything goes wrong. I am not affiliatet with the Cloud Net team in any kind. If you need help related to CloudNet join the [CloudNet Discord](https://discord.gg/Qr6eRtNUT6). 
>
> If anything related to this egg should not work you can open an issue or contact me via [discord](https://discord.com/channels/@me/871699097915109416)

# Pterodactyl
* Use this Pterodactyl egg to install CloudNet V4 in a container. This egg features a custom [docker image](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/dockerfile) and a [entrypoint.sh](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/entrypoint.sh) file.
* The entrypoint.sh file updates the CloudNet launcher configuration on every start to ensure the correct ip and memory limit.

# Installation
1. Go to your Pterodactyl Admin Panel
2. Navigate to Nests and create a new Nest
3. Go back to nests and Import an Egg
4. Insert your [downloaded egg file](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/eggs/cloudnet/egg-CloudNetV4.json)
5. Save and create a new Server, set the CloudNet Version to 11 or newer and create

# Setup CloudNet
> [!IMPORTANT]
> Usually the default CloudNet setup will be skipped. You have to create the default Proxy and Lobby services manually
> 
> You can follow the setup below or create your own Tasks

1. Create a Proxy task by using the command "task Setup"
2. Set the name to "Proxy". Next set the memory, you will notice that due to console input issues in pterodactly the memory will be set to 512+your memory, ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you may have to input it twice). In the next step select if the service schould be static yes/no, recomendation: "no". Then input how many Proxys you want to have for Proxy you should input "1" this keeps the setup easy. In the Next step you have to select your Proxy type VELOCITY/BUNGEECORD. In the next step its important you set the port of your Pterodactyl container which you use to join with your Minecraft client, you see this port behind the ip or domain in you server panel for example myhostdomain.de:25001, the port is 25001. Next step input you java command, you can leave "java". Next input your desired version depending on you server type, example: "velocity-latest". In the last step input a name splitter, example: "-" for services to show in this format "Proxy-1".
3. You may get an Error and you will see that no service is starting, you have to set the memory manually. Use the command "tasks task Proxy set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup. After this you Proxy will start
4. If the Proxy service doesn't start restart your container and set maintenance to "false" using the command "tasks task Proxy set maintenance  false".
5. Now try to connect using your minecraft client use the newest version of the game you can add legacy support using [ViaVerion](https://www.spigotmc.org/resources/viaversion.19254/) and [ViaBackwards](https://www.spigotmc.org/resources/viabackwards.27448/)
6. The proxy is now created. Follow the guide below to add a Fallback service, which you need

> [!TIP]
> CloudNet needs a fallback configuration to work. This means a fallback task has to be created. Use the tutorial below to create not just a fallback task, but any future task you want to create

*  The Proxy is crated, you can now create all your normal CloudNet tasks. You have to set one as the fallback task, where all players connecting will join. For example "Lobby"
1. Again execute the command "tasks setup"
2.  Set the name to "Lobby". Next set the memory, you will see that due to console input issues in pterodactly the memory will be set to 512+your memory ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you may have to input it twice). In the next step select if the service schould be static yes/no, recomendation: "no". Then input how many services you want to have, for example "2". In the next step you have to select your service type, you can use all types, recomendation "MINECRAFT_SERVER". In the next step you can select any port to start, please watch out to not use any twice or use a port allready in use. Next step put in you java command, you can leave "java", in this version of cloudnet you don't need a differnt java version or jdk to use a legacy version. Next input your desired version depending on you server type, for example paper/purpur or spigot. For a lobby I reccomend purpur so in this case "purpur-latest". In the last step input a name splitter, example: "-" for services to show in this format "Proxy-1".
3. You may get an Error and you will see that no service is starting you have to set the memory manually. Use the command "tasks task {task-name} set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup {task-name}. After this you Proxy will start
4. If the service doesn't start restart your container and set maintenance to "false" using the command "tasks task {task-name} set maintenance  false".

> [!CAUTION]
> Your probably can't connect to your server due to missing CloudNet modules and a missing fallback configuration
> Follow the guide below to install the missing modules and set a fallback configuration.

1. You need the CloudNet-Bridge and theCloudNet-SyncProxy module install them with "modules install CloudNet-Bridge" and "modules install CloudNet-SyncProxy"
2. Navigate in the folder /modules/CloudNet-Bridge/config.json and set the Fallback task name. For example: "defaultFallbackTask": "Lobby"

> [!WARNING]
> If you use the "tasks setup" command in the pterodactyl sometimes your input isn't recived properly, causing wierd memory configurations
> For example if you input the memory in the setup process cloudnet will think you set the memory to 512+your selected memory
> In most cases this overfloods the max memory set in the launcher configuration causing an error. To fix this execute the command below
* "tasks task {task-name} set maxHeapMemory {memory}" Make sure to input the correct task name and the correct memmory in MB.