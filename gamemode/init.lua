--Server files
include("shared.lua")
include("sv_player.lua")

--Client files
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")

util.AddNetworkString("bb_updatetool")
util.AddNetworkString("bb_timerstart")
util.AddNetworkString("bb_timerend")

TEAM_BLUE = 1
team.SetUp(TEAM_BLUE, "Blue", Color(0, 0, 240, 255))

TEAM_RED = 2
team.SetUp(TEAM_RED, "Red", Color(240, 0, 0, 255))

net.Receive("bb_updatetool", function(len, ply)
	if not ply then return end
	local newSelection = net.ReadInt(8)

	ply:GetActiveWeapon():ResetSelection()
	ply:GetActiveWeapon().ObjectToPlace = GAMEMODE.ShopItems[newSelection]
end)