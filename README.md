# NOTIF
Notifications with original GTA V look, but more flexible.

<img src=https://imgur.com/1rd5qwi.png>

## Installation
* Download the resource ;
* Drag and drop it in your resources folder ;
* Add ```start notif``` into you ```server.cfg```.
## How to use
* Use the export below :
```lua
exports.notif:SendNotification({
	text = "Test text.",
	type = 'topRight',
	timeout = 6000,
})
```

## Options 
* ```type``` define where the notification will be draw ;
* ```timeout``` define how much time (in ms) the notification is on screen ;
* You can create your own notification 'type' by following the pattern in the code.

## Updates
No updates yet.

## Known bugs
* Doesn't deal with duplicate notifications (not as default notifications do) ;
* The centerLeft and centerRight options have some issues ;
* Notifications with different timeout will create issues.
