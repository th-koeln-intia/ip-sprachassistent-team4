---
layout: default
title: Zigbee
has_children: true
parent: Knowledge
---

# Zigbee

## What is Zigbee?
Zigbee is a very energy efficient network system to connect IoT devices like lights, switches, sensors and other 
devices for home automation these are named nodes. 
The Zigbee network is a WPAN(Wireless Personal Area Network), the range in buildings is 10-20 meters and on a free 
field 100m. 

## What are nodes exactly?
There are three different types of nodes. These types are Zigbee End Device, Zigbee Router and Zigbee Coordinator.
- A Zigbee End Device is a Reduced-Function Device (RFD) that can only send data, but not receive or route it to other 
devices. It can only connect to a Zigbee Router or a Zigbee Coordinator, but not to other Zigbee End Devices.    
- A Zigbee Router is Full-Function Device (FFD), it's responsible for the message routing in the network. A router 
receives, sends and route messages. It connects with Zigbee End Devices and Zigbee Coordinators and other Zigbee 
Routers, the result is a mesh network, so devices much farther away from the coordinator than 100m can be reached, 
cause of the mesh network.       
- A Zigbee Coordinator creates the Zigbee network, it's responsible for the Zigbee channel and the unique IDs for 
all nodes.
