# [Cloud Net](https://cloudnetservice.io/)
A modern application that can dynamically and easily deliver Minecraft oriented software

# [Cloud Net V4](https://github.com/CloudNetService/CloudNet/releases)

This Egg only supports CloudNet V4 a experimental version of cloudnet.
I reccomend the generall usage of the new version due to newer implementations and features

> [!IMPORTANT] 
> Its Really Important to use Version 4.0.0-RC11 or newer because it implements a [fixed version of jline](https://github.com/CloudNetService/CloudNet/pull/1441)
> 
> I only created this egg and tutorial, I am not able to be held responsible if anything goes wrong. I am not affiliatet with the Cloud Net team in any kind. If you need help related to CloudNet join the [CloudNet Discord](https://discord.gg/Qr6eRtNUT6). 
>
> If anything related to this egg should not work you can open an issue or contact me via [discord](https://discord.com/channels/@me/871699097915109416)

# Pterodactyl
* Use this Pterodactyl egg to install CloudNet V4 in a container. This egg features a custom [docker image](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/dockerfile) and a [entrypoint.sh](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/entrypoint.sh) file.
* The entrypoint.sh file updates the CloudNet launcher configuration on every start to ensure the correct ip and memory limit.

### Wings Settings
For bigger CloudNet Networks (more than 4 Services) increase `container_pid_limit` in the `/etc/pterodactyl/config.yml` file to more than 512 for example 3512. Don't foget to restart wings `service wings restart`\
For more information: [pterodactyl wings configuration](https://pterodactyl.io/wings/1.0/configuration.html#container-pid-limit)
- 4 Processes are 512 pid (not multi threaded)
- the bigger the network, the more pid's you need. If you want to use multi threaded services like Folia or [MultiPaper](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/CloudNet%2BMP) set the limit to `3512`

# Installation
1. Go to your Pterodactyl Admin Panel
2. Navigate to Nests and create a new Nest
3. Go back to nests and Import an Egg
4. Insert your [downloaded egg file](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/eggs/cloudnet/egg-CloudNetV4.json)
5. Save and create a new Server, set the CloudNet Version to 11 or newer and create

# Setup CloudNet
> [!CAUTION]
> Usually the default CloudNet setup will be skipped. You have to create the default Proxy and Lobby services manually
> If the setup works, finish it and make sure to follow the steps in [#Important](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#important) to make sure CloudNet Works
> 
> You can follow the setup below or create your own Tasks

1. Create a Proxy task by using the command "task Setup"
2. Set the name to "Proxy". Next set the memory, you will notice that due to console input issues in pterodactly the memory will be set to 512+your memory, ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you may have to input it twice). In the next step select if the service schould be static yes/no, recomendation: "no". Then input how many Proxys you want to have for Proxy you should input "1" this keeps the setup easy. In the Next step you have to select your Proxy type VELOCITY/BUNGEECORD. In the next step its important you set the port of your Pterodactyl container which you use to join with your Minecraft client, you see this port behind the ip or domain in you server panel for example myhostdomain.de:25001, the port is 25001. Next step input you java command, you can leave "java". Next input your desired version depending on you server type, example: "velocity-latest". In the last step input a name splitter, example: "-" for services to show in this format "Proxy-1".
3. You may get an Error and you will see that no service is starting, you have to set the memory manually. Use the command "tasks task Proxy set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup. After this you Proxy will start
4. If the Proxy service doesn't start restart your container and set maintenance to "false" using the command "tasks task Proxy set maintenance  false".
5. Now try to connect using your minecraft client use the newest version of the game you can add legacy support using [ViaVersion](https://www.spigotmc.org/resources/viaversion.19254/) and [ViaBackwards](https://www.spigotmc.org/resources/viabackwards.27448/)
6. The proxy is now created. Follow the guide below to add a Fallback service, which you need

> [!TIP]
> CloudNet needs a fallback configuration to work. This means a fallback task has to be created. Use the tutorial below to create not just a fallback task, but any future task you want to create

*  The Proxy is crated, you can now create all your normal CloudNet tasks. You have to set one as the fallback task, where all players connecting will join. For example "Lobby"
1. Again execute the command "tasks setup"
2.  Set the name to "Lobby". Next set the memory, you will see that due to console input issues in pterodactly the memory will be set to 512+your memory ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you may have to input it twice). In the next step select if the service schould be static yes/no, recomendation: "no". Then input how many services you want to have, for example "2". In the next step you have to select your service type, you can use all types, recomendation "MINECRAFT_SERVER". In the next step you can select any port to start, please watch out to not use any twice or use a port allready in use. Next step put in you java command, you can leave "java", in this version of cloudnet you don't need a differnt java version or jdk to use a legacy version. Next input your desired version depending on you server type, for example paper/purpur or spigot. For a lobby I reccomend purpur so in this case "purpur-latest". In the last step input a name splitter, example: "-" for services to show in this format "Proxy-1".
3. You may get an Error and you will see that no service is starting you have to set the memory manually. Use the command "tasks task {task-name} set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup {task-name}. After this you Proxy will start
4. If the service doesn't start restart your container and set maintenance to "false" using the command "tasks task {task-name} set maintenance  false".

# Important

> [!CAUTION]
> Your probably can't connect to your server due to missing CloudNet modules (a missing fallback configuration) and the Proxy port not being correct. This can be fixed quite easy with the guides below.
>
> If you used the default CloudNet setup (not the version provided above), set the correct Port of your Proxy and allow players to join using the [Correct-Port guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#correct-port)
> 
> Follow the [Missing-Modules-Fallback guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#missing-modules-fallback) to install the missing modules and set a fallback configuration.


> [!WARNING]
> If you use the "tasks setup" command in the pterodactyl sometimes your input isn't recived properly, causing wierd memory configurations
> For example if you input the memory in the setup process cloudnet will think you set the memory to 512+your selected memory
> In most cases this overfloods the max memory set in the launcher configuration causing an error. To fix this follow the [Wrong-Input guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#wrong-input)
  
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

Made with ❤️ by @lostesburger (inspired by deprecated CloudNet v3 egg by @KeksGauner)