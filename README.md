# Gun Range Test

## Dependencies
* ox_lib
* qb-core (Can be easily adapted to ox or qbx)

## Preview
https://github.com/complexza/complex-gunrange/assets/74205343/dc4b3088-a46b-4f1b-b3ef-d90b3256dcd0

## Description
A simple firearms test at Ammunition.

## Installation
`qb-core > shared > items.lua (Old Format)`
```lua
['gunrangereceipt'] 				 = {['name'] = 'gunrangereceipt', 			  	 ['label'] = 'Firearms Range Receipt', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'ticket.png', 					['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Receipt from the your firearms test!'},
```
`qb-core > shared > items.lua (New Format)`
```lua
gunrangereceipt               = { name = 'gunrangereceipt', label = 'Fists', weight = 1000, image = 'ticket.png', unique = true, useable = false, description = 'Test Results from Firing Range' },
```

`qb/ps-inventory > html > js`
```js
} else if (itemData.name == "gunrangereceipt") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html(
                '<p><strong>Paid by: </strong><span>' + itemData.info.citizenname + '</span></p>' +
                '<p><strong>Final Score: </strong><span>' + itemData.info.score + '</span></p>' +
                '<p><strong>Date Issued: </strong><span>' + itemData.info.date + '</span></p>'
);
```

## Configuration
* Change Zone Settings & Locations
* Change Target Popup Locations
* Change Blip Settings & Locations

## Updates for later maybe
* More Optimizations.
* More Effects when doing the test.
* More Customization
* More Small Bug Fixes

## Original Idea / Snippets by Just Evy
* Used The Animation and Targeting Spawning Logic
[](https://github.com/justevy/shootingrange)https://github.com/justevy/shootingrange
