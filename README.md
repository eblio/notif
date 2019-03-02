# NOTIF
Notifications with original GTA V look, but more flexible.

<img src=https://imgur.com/1rd5qwi.png>

## Installation
* Download the resource ;
* Drag and drop it in your resources folder ;
* Add ```start notif``` into you ```server.cfg```.
## How to use
* In the chat type /me followed by your action 
```exports['notif'].SendNotification("lol")```

## Options 
* Color of the text : ```client.lua``` line 1 : ```local color = {r = 37, g = 175, b = 134, alpha = 255}```
* Font of the text : ```client.lua``` line 2 : ```local font = 0``` Available fonts : https://imgur.com/a/oV3ciWs
* Time on screen : ```client.lua``` line 2 : ```local time = 500```
* Enable or disable the log : ```server.lua``` line 1 : ```local logEnabled = true```

## Updates
No updates yet.

## Known bugs
* The centerLeft and centerRight options have some issues ;
* Notifications with different timeout will create issues.
