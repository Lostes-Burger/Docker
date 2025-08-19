# [Cloud Net V4](https://cloudnetservice.io/)
A modern application that can dynamically and easily deliver Minecraft oriented software
This Egg only supports [CloudNet V4](https://github.com/CloudNetService/CloudNet/releases), a experimental (pre-release) version of cloudnet.

> [!IMPORTANT] 
> This egg only works due to a new implementation in the V4-RC-11 pre-release, a [fixed version of jline](https://github.com/CloudNetService/CloudNet/pull/1441)
> 
> I only created this egg and tutorial, I am not able to be held responsible if anything goes wrong. I am not affiliatet with the CloudNet / Pterodactyl / Pelican team in any kind. 
> If you need help related to CloudNet join the [CloudNet Discord](https://discord.gg/Qr6eRtNUT6). 
> If you need help setting up or importing an egg in Pelican, join the [Pelican](https://discord.gg/pelican-panel)
> If you need help setting up or importing an egg in Pterodactyl, join the [Pterodactyl](https://discord.gg/YM9A4PPM8h)
> If anything related to this egg should not work you can open an issue or contact me via [discord](https://discord.com/channels/@me/740233346919170058)

# Pterodactyl / Pelican
* Use this Pterodactyl / Pelican egg to install CloudNet V4 in a container. This egg features a custom [docker image](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/dockerfile) and a [entrypoint.sh](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/images/cloudnet/entrypoint.sh) file.
* The entrypoint.sh file updates the CloudNet launcher configuration on every start to ensure the correct ip and memory limit.

### Wings Settings
For bigger CloudNet Networks (more than 4 Services) increase `container_pid_limit` in the `/etc/pterodactyl/config.yml` file to more than 512 for example 3512. Don't foget to restart wings `service wings restart`\
For more information: [pterodactyl wings configuration](https://pterodactyl.io/wings/1.0/configuration.html#container-pid-limit)
- 4 Processes are 512 pid (not multi threaded)
- the bigger the network, the more pid's you need. If you want to use multi threaded services like Folia or [MultiPaper](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/CloudNet%2BMP) set the limit to `3512`

# Installation
1. Go to your Pterodactyl / Pelican Admin Panel
2. Navigate to Nests and create a new Nest (Pterodactyl only)
3. Go back to nests and Import the Egg (Peterodactyl only)
3. Go to eggs and Import the Egg (Pelican only)
4. Insert your [downloaded egg file](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/eggs/cloudnet/egg-CloudNetV4.json)
5. Save and create a new Server.

# Important
> [!CAUTION]
> Your probably can't connect to your server due to missing CloudNet modules (a missing fallback configuration) and the Proxy server not binding to the correct port. If you are not using the default port 25565 follow [this port guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#correct-port).
> 
> Follow the [Missing-Modules-Fallback guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#missing-modules-fallback) to install the missing modules and set a fallback configuration.


> [!WARNING]
> If you use the "tasks setup" command in the pterodactyl sometimes your input isn't recived properly, causing corrupt memory values in the task configurations 
> For example if you input the memory in the setup process cloudnet will think you set the memory to 512+your selected memory (input: 3000 -> config recives: 3000512 -> overloads and won't start the server)
> In most cases this overloads the max memory set in the launcher configuration causing an error. To fix this follow the [Wrong-Input guide](https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#wrong-input)
  
# Wrong-Input
* The "tasks setup" command, the inputs are not allways detected correctly. If you input the memory CloudNet will create the configuration with 512+memory MB (input: 3000 -> config recives: 3000512 -> overloads and won't start the server). To fix this use the command below. Replace the Placeholders {task-name} (name of task) and {memory} (with the prefered memory in MB)
1. `tasks task {task-name} set maxHeapMemory {memory}`

# Missing-Modules-Fallback
* In CloudNet V4 the default Modules are not installed, they need to be installed and configured correctly. Follow this guide below to install the correct Modules and add a fallback task. This is needed to join the Minecraft server.
1. You need the CloudNet-Bridge and theCloudNet-SyncProxy module install them with `modules install CloudNet-Bridge` and `modules install CloudNet-SyncProxy`
2. Open the config.json in /modules/CloudNet-Bridge/config.json and set the Fallback task name. For example: `"defaultFallbackTask": "Lobby"`
3. Restart the entire network.

# Correct-Port
* This is only important for you if you've setup CloudNet via the internal Setup and didn't created the Tasks manually. CloudNet doesn't know the correct port for your Proxy to start. The default port 25565 is set, which in most cases, when using pterodactyl / pelican is already in use.
* To set the correct Proxy port, use the command below and replace the placeholders {task-name} (The Name of your Proxy task, default is "Proxy") and the Port {port}. 
* The port is behind your server adress in the server's dashboard. E.g. Adress: serverdomain.de:25000, the port is 25000.
1. `tasks task {task-name} set startPort {port}`

Made with ❤️ by @lostesburger (inspired by deprecated CloudNet v3 egg by @KeksGauner)