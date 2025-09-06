# [Minecraft TCP Router](https://github.com/Lostes-Burger/MinecraftTcpRouter) Pelican / Pterodactly egg
Minecraft TCP Router is a lightweight, domain-based TCP router for Minecraft servers.
It listens for incoming Minecraft connections and routes them to different servers based on the domain the client connected with – all without modifying packets or acting as a full Minecraft proxy.

This egg automatically installes the [Minecraft TCP Router](https://github.com/Lostes-Burger/MinecraftTcpRouter) application and keeps it up to date.

### Installation
1. Download egg above.
2. Upload egg in Pelican / Pterodactyl panel.
3. Create server with 1 Allocation for incomming tcp traffic (preferably 25565)

### Hardware
- 1 Thread (100% cpu)
- 512MB of Memory 
- 1G Strorage

For larger setups with more than 30 players, please allocate more resources.

## Routes configuration
There are 2 ways you can set up the routing ips:

Option 1 (recommended):
All minecraft servers are only accessible through the Router on port 25565 and are Routed internaly.
Using this option: the internal docker ip adress is used to route the players, wich is HIGHLY recommended.

1. Finding out your pelican / pterodactyl network ip adress:
    Pelican: `docker network inspect pelican_nw | grep Gateway`
    Pterodactly: `docker network inspect pterodactyl_nw | grep Gateway`
    Use the ipv4 shown in your configuration. The default in most installes is `172.18.0.1`

2. Set the the allocation's ip in the node config:
    If you create an allocation the default ip adress servers use will likely be your server's public ip adress.
    This does'n work for our setup due to the server's container binding to the public ip.
    Select the ip from the pelican/pterodactly network (likely 172.18.0.1) in the menu.
    You can find this setting in the nodes config in the allocations tab.

3. Enter your docker network ip (default 172.18.0.1) as host in the config.json.

Option 2 (not recommended):
All minecraft servers are accessible trough the Router and their default allocation.
Again I encurage all users to use the first option.

1. Copy the ip adress of the wanted minecraft server. Make sure you get the ipv4 adress, domain based works but is not 100% reliable in this case.
2. Enter the ipv4 (like 2.121.120.111) as host in the config.json.