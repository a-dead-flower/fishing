# Fishing

## Known Bugs
- Using all bait of a specific kind without resetting the global "current_bait" and then visiting the shop will result in the bait being displayed at a value of 0
- When casting, the cast can be interupted during travel by holding down the left mouse

## 0.0.13 WIP
- Fixed Vulkan bug by adding an OpenGL shader ontop of everything (???)
- Fixed fish sorting by price and name in shops bug
- Added stats info to shop items instead of only for upgrades
- Reworked interface for the bestiary for more consistant styling
- Added the two remaining rods to the game
- Capped money to 999,999 because I don't want to resize the shops

## 0.0.12
- Added repository to GitHub!
- New inventory space limitations
- Created tooltips for shop and menu items
- Fixed audio bug causing large gaps in audio under high load
- Optimised shop item animations
- Changed bait array from static to dynamic
- Added ability to delete fish from inventory
- Fixed bestiary shadow shaders
- Completed menu mechanics for upgradable items
- Equipment now only shows info if there is something selected
- Added grass, planks and dirt walking sounds
- Added water splash and retrieval sounds
- Added ambient wind and water sounds
- Added UI sound effects
- Ability to seamlessly change the walking sounds
- "New Fish" and "New Best" messages
- Physics frame rate changed to 120FPS to avoid visual stutter when walking
- Information for menus is now on by default
- Shops are now switchable and customisable
- Ambient audio is dimmed on menu opening
- Mute button in settings is cooler
- Overhauled buy and sell code for items
- Lures added with set durability
- Lures value is now dependant on a multiplier * durability
- Time runs at 1/10th the speed
- Popup for full inventory allows walking
- Sprites for upgrade menu Added
- Sprites for inventory full and no rod equip added
- Audio bus config layout setup for different audio channels
