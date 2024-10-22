# [Cloud Net](https://github.com/CloudNetService/CloudNet)
A modern application that can dynamically and easily deliver Minecraft oriented software

# [Cloud Net V4](https://github.com/CloudNetService/CloudNet/releases)
This Egg only supports the Re-Release V4 of CloudNet due to newer Implementations

Its Really Important to use Version 4.0.0-RC11 because it implements a [fixed version of jline](https://github.com/CloudNetService/CloudNet/pull/1441)

Consider this a test Version of 

# Pterodactyl
This Pterodactyl Egg enables the use of CloudNet v4 the Installation and Setup Process is described below

# Installation
1. Go to your Pterodactyl Admin Panel
2. Navigate to Nests and create a new Nest
3. Go back to nests and Import an Egg
4. Insert your [downloaded egg file](https://github.com/Lostes-Burger/docker/blob/main/pterodactyl/eggs/cloudnet/egg-CloudNetV4.json)
5. Save and create a new Server, set the CloudNet Verion to 11 or newer and create

# Setup after installation
* Most of the times the default Setup will be skipped so you have to create the default Proxy and Lobby manually
1. Create a Proxy by using the command "tast Setup"
2. Set the name to "Proxy". Next set the memory you will see that due to console input issues in pterodactly the memory will be set to 512+your memory ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you maybe have to input it twice). In the next step select if the service schould be static yes/no, I reccomand no. Then Input how many Proxys you want to have for Proxy you should input "1" this keeps the setup easy. In the Next step you have to select your Proxy type VELOCITY/BUNGEECORD. In the next step it is important you set the port of your Pterodactyl container which you use to join you see this port behind the ip or domain in you server panel. Next step put in you java command, you can leave "java". Next Input your desired verion depending on you server type like "velocity-latest". For the name splitter put "-" so your services names have this formt "Proxy-1".
3. You may get an Error and you will see that no service is starting you have to set the memory manually. Use the command "tasks task Proxy set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup. After this you Proxy will start
4. If the Proxy service doesn't start restart your container and set maintenance to "false" using the command "tasks task Proxy set maintenance  false".
5. Now try to connect using your minecraft client use the newest version of the game you can add legacy support using [ViaVerion](https://www.spigotmc.org/resources/viaversion.19254/) and [ViaBackwards](https://www.spigotmc.org/resources/viabackwards.27448/)

*  The Proxy is now crated you can now create all your normal CloudNet tasks. You have to set one al the Fallback server, where all players connecting will join. For example "Lobby"
1. Again execute the command "tasks setup"
2.  Set the name to "Lobby". Next set the memory you will see that due to console input issues in pterodactly the memory will be set to 512+your memory ignore this we will fix it later. In the next Step select if you want maintenance yes/no (you maybe have to input it twice). In the next step select if the service schould be static yes/no, I reccomand no. Then Input how many services you want to have for example "2". In the Next step you have to select your service type you can use all types i will use "MINECRAFT_SERVER". In the next step you can select any port to start, please watch out to not use any twice or use a port allready in use. Next step put in you java command, you can leave "java" if you want to start a service using an older verion of java like 1.8 you need an older version of java I put a tutorial below. Next Input your desired verion depending on you server type like paper/purpur or spigot for a lobby I reccomend purpur so in this case "purpur-latest". For the name splitter put "-" so your services names have this formt "Lobby-1".
3. You may get an Error and you will see that no service is starting you have to set the memory manually. Use the command "tasks task {task-name} set maxHeapMemory {memory}" set the memory at the end and make sure to input the correct name you set in the setup {task-name}. After this you Proxy will start
4. If the service doesn't start restart your container and set maintenance to "false" using the command "tasks task {task-name} set maintenance  false".

* If you can't connect to your server it's because you have not set a fallback task to do this we have to install some modules.
1. You need the CloudNet-Bridge and theCloudNet-SyncProxy module install them with "modules install CloudNet-Bridge" and "modules install CloudNet-SyncProxy"
2. Navigate in the folder /modules/CloudNet-Bridge/config.json and set the Fallback task name like "defaultFallbackTask": "Lobby"

# Stating old versions of minecraft using a jdk with a differnt java version
* Depending on your java and minecraft version you will still not be able to join due to java 23 beeing to new for minecraft we need to install a jdk and use it to start the service.
1. You need to find out wich java version is needed for your server version. You can find a list [here at minecraft Wiki](https://minecraft.wiki/w/Tutorials/Setting_up_a_server) (Java Version)
2. In my case i am using purpur-1.21.1 so i need java 21 go to [OpenLogic OpenJDK](https://www.openlogic.com/openjdk-downloads?field_java_parent_version_target_id=828&field_operating_system_target_id=426&field_architecture_target_id=All&field_java_package_target_id=396) select linux and your wantet java version and download as tar.gz
3. The file may be too large to upload throught the web then you have to use the pterodactyl sftp. Unpack the tar.gz using the pterodactyl pannel or upload it unzipt from your computer.
4. Rename to file to make it easier like openjdk-21 now you have the correct jdk in the next step we have to set the tasks java command
5. In this step its really importent to get the correct path to the java file in my case the jdk is in the home/container/ folder so i have to navigate to the java file using /home/container/openjdk-21/bin/ and add the file "java". For me its /home/container/openjdk-21/bin/java.
6. Use the "tasks task {task-name} set javaCommand {path}" command to set the correct java command. Replace {path} with your path from above like "/home/container/openjdk-21/bin/java" and set the correct {task-name} in my case Lobby. I executed: "tasks task Lobby set javaCommand /home/container/openjdk-21/bin/java"
7. Depending on your download mehtod of the jdk you weill get a permission error then you have to ssh in the volume folder and execute chmod +x openjdk-21/
8. Now restart all services of the tast using "service {task-name}--* delete" replace -- with your splitter set in the task and replace {task-name} with your task name