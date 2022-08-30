# Simple-Trash-DarkRP
Add a trash can and dumpster and allow hobos to collect trash and sell to an npc for some extra cash.

https://steamcommunity.com/sharedfiles/filedetails/?id=2856473070

This is a nice little basic trash collection system with an dumpster, trashcan and trash buyer NPC. This is set by default to the Hobo job.

## Extra Info
This is for the Hobo only by default.
You can check you current trash you are holding by typing in the chat box either **/trash** or **!trash** this will then tell you in chat how much if any you have on you.
The trash has a min and max and gives a random amount between them.

## How to configure
## Entity Config
You can spawn the ents in on the Q menu then save them as explained below.
You can save the trash ent locations on the current map by using console command **simpletrash_saveents**.
You can remove the trash ent locations on the current map by using console command **simpletrash_removeents** this will prevent them spawning on the next restart..
You can respawn the trash ent locations on the current map by using console command **simpletrash_respawnents** this is handy if you just saved them or updated the saves it will remove them from the map and reload from the file so if you move one by mistake then use the respawn command and it will fix its position.

## Addon Config
You can set the min amount of trash you collect by setting **simpletrash_amountmin xxx** in your server console. **(Default = 1 piece of trash)**
You can set the min amount of trash you collect by setting **simpletrash_amountmax xxx** in your server console. **(Default = 5 pieces of trash)**
You can set the min amount of cooldown by setting **simpletrash_cooldownmin xxx** in your server console. **(Default = 60 seconds)**
You can set the min amount of cooldown by setting **simpletrash_cooldownmax xxx** in your server console. **(Default = 120 seconds)**
You can set the sell price of the trash by setting **simpletrash_sellprice xxx** in your server console. **(Default = 200 per piece of trash)**

## How to use
Change to Hobo then go around the map pressing *E (Use)* on the trash cans and dumpsters and once you have collected some trash press *E (Use)* on the buyer to sell for some money.
