AddCSLuaFile()

SWEP.Author = "SuperSponer"
SWEP.PrintName = "Entity Deconstructor"
SWEP.Instructions = "Destroy entities and get your money back\nMouse 1 - Destroy the entity"
SWEP.Base = "weapon_base"

SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"

SWEP.Slot = 0
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ShouldDropOnDie = false

SWEP.ObjectToPlace = nil

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	
	local ply = self.Owner
	
	if ply:GetEyeTrace().Hit and ply:GetEyeTrace().Entity and ply:GetEyeTrace().Entity.owner == ply then
		ply:SetNWInt("bb_cash", ply:GetNWInt("bb_cash") + ply:GetEyeTrace().Entity.refund)
		ply:GetEyeTrace().Entity:Remove()
	end
end

function SWEP:SecondaryAttack()
	return
end