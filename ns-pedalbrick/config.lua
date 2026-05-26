Config = {}
Config.Locale = 'en'

----- Framework / Inventory / Target
framework = "qbx" ---- write "qb" for QBCore or qbx for Qbox
itemname = "murstein" ---- Item Name
target = "ox_target" ---- Support for ox_target an qb-target
inv = "ox_inventory" ---- if you use QB write qb-inventory 

-- Props list for aquiring the bricks.
--  Here you can add which prop to pickup bricks
mursteiner = {
    "prop_pile_dirt_02",
    "ng_proc_brick_01a",
    "prop_conc_blocks01b",
}

-- Pedal / Vehicle related
time = -1 ---- How long you want the car to drive before it stops in ms example time = 30000 means 30 seconds
breakcar = false ----- if you want to break the car when it hits stuff "One way trip then turn this to true"