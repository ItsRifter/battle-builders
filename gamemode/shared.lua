GM.Name = "Battle Builders"
GM.Author = "SuperSponer"
GM.Email = "d_thomas_smith30@hotmail.com"
GM.Website = "N/A"

GM.ShopItems = {}

function CreateShopEntity(newItem)
	table.insert(GM.ShopItems, newItem)
end

local wall_wood = {
	["name"] = "Wall: Wood",
	["model"] = "models/hunter/plates/plate2x2.mdl",
	["mat"] = "phoenix_storms/wood",
	["health"] = 30,
	["cost"] = 25,
	["rot"] = Angle(90, 0, 0)
}

CreateShopEntity(wall_wood)

local wall_metal = {
	["name"] = "Wall: Metal",
	["model"] = "models/hunter/plates/plate2x2.mdl",
	["mat"] = "phoenix_storms/metalset_1-2",
	["health"] = 85,
	["cost"] = 75,
	["rot"] = Angle(90, 0, 0)
}

CreateShopEntity(wall_metal)

local cube_wood = {
	["name"] = "Cube: Wood",
	["model"] = "models/hunter/blocks/cube1x1x1.mdl",
	["mat"] = "phoenix_storms/wood",
	["health"] = 40,
	["cost"] = 45
}

CreateShopEntity(cube_wood)

local cube_metal = {
	["name"] = "Cube: Metal",
	["model"] = "models/hunter/blocks/cube1x1x1.mdl",
	["mat"] = "phoenix_storms/metalset_1-2",
	["health"] = 115,
	["cost"] = 85
}

CreateShopEntity(cube_metal)

local plat_wood = {
	["name"] = "Platform: Wood",
	["model"] = "models/hunter/plates/plate2x2.mdl",
	["mat"] = "phoenix_storms/wood",
	["health"] = 30,
	["cost"] = 25
}

CreateShopEntity(plat_wood)

local plat_metal = {
	["name"] = "Platform: Metal",
	["model"] = "models/hunter/plates/plate2x2.mdl",
	["mat"] = "phoenix_storms/metalset_1-2",
	["health"] = 75,
	["cost"] = 75
}

CreateShopEntity(plat_metal)

local turret = {
	["name"] = "Turret",
	["model"] = "models/combine_turrets/floor_turret.mdl",
	["mat"] = nil,
	["cost"] = 150,
	["npc"] = "npc_turret_floor"
}

CreateShopEntity(turret)