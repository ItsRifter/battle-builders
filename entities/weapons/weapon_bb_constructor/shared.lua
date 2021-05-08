AddCSLuaFile()

SWEP.Author = "SuperSponer"
SWEP.PrintName = "Entity Constructor"
SWEP.Instructions = "Create entities with ease\nMouse 1 - Place selected object\nMouse 2 - Select an object\nE or R to rotate"
SWEP.Base = "weapon_base"


SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ViewModel = "models/weapons/v_slam.mdl"

SWEP.Slot = 0
SWEP.SlotPos = 1
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
	self:SetWeaponHoldType("slam")
end

function SWEP:Deploy()
	if CLIENT then return end
	
	self.ObjectToPlace = nil
end

function SWEP:Holster()
	if CLIENT then return end
	if IsValid(self.Owner.ghostlyEnt) then self.Owner.ghostlyEnt:Remove() end
	return true
end

function SWEP:Think()
	if CLIENT then return end
	if self.ObjectToPlace == nil then return end
		
	if self.Owner:KeyPressed(IN_USE) and IsValid(self.Owner.ghostlyEnt) then
		self.Owner.ghostlyEnt:SetAngles(self.Owner.ghostlyEnt:GetAngles() + Angle(0, 15, 0))
	end
	
	if self.Owner:KeyPressed(IN_RELOAD) and IsValid(self.Owner.ghostlyEnt) then
		self.Owner.ghostlyEnt:SetAngles(self.Owner.ghostlyEnt:GetAngles() - Angle(0, 15, 0))
	end
	
	self.Owner.pointBounds = nil
	
	if self.Owner:GetEyeTrace().HitPos:Distance(self.Owner:GetPos()) >= 150 then 
		if IsValid(self.Owner.ghostlyEnt) then 
			self.Owner.ghostlyEnt:Remove()
		end
	end
	
	if self.Owner:GetEyeTrace().Hit and self.Owner:GetEyeTrace().Entity and self.Owner:GetEyeTrace().HitNonWorld then
		--self.Owner.pointBounds = (self.Owner:GetEyeTrace().Entity:GetHitBoxBounds(self.Owner:GetEyeTrace().HitBox, 0) / 8)
		self.Owner.pointBounds = self.Owner:GetEyeTrace().Entity:GetCollisionBounds() / 8
	else
		self.Owner.pointBounds = nil
	end

	
	if IsValid(self.Owner.ghostlyEnt) then 
		if self.Owner.pointBounds ~= nil then
			self.Owner.ghostlyEnt:SetPos(self.Owner:GetEyeTrace().HitPos + self.Owner.pointBounds)
		else
			self.Owner.ghostlyEnt:SetPos(self.Owner:GetEyeTrace().HitPos)
		end
		return 
	end
	
	local ghostEnt = ents.Create("prop_dynamic")
	ghostEnt:SetModel(self.ObjectToPlace["model"])
	ghostEnt:SetMaterial("models/wireframe")
	if self.ObjectToPlace["rot"] then
		ghostEnt:SetAngles(self.ObjectToPlace["rot"])
	end
	ghostEnt:Spawn()
	self.Owner.ghostlyEnt = ghostEnt
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	if self.ObjectToPlace == nil then return end
	
	local object = nil
	
	if self.ObjectToPlace["npc"] then
		object = ents.Create(self.ObjectToPlace["npc"])
		for k, pl in pairs(player.GetAll()) do
			if pl:Team() == self.Owner:Team() then
				object:AddEntityRelationship(pl, D_LI, 99)
			else
				object:AddEntityRelationship(pl, D_HT, 99)
			end
		end
	else
		object = ents.Create("prop_dynamic")
	end
	
	
	if self.Owner:GetEyeTrace().HitPos:Distance(self.Owner:GetPos()) >= 150 then return end
	
	if self.Owner:GetNWInt("bb_cash") < self.ObjectToPlace["cost"] then return end
	
	object:SetModel(self.ObjectToPlace["model"])
	object:SetMaterial(self.ObjectToPlace["mat"])
	object:SetPos(self.Owner.ghostlyEnt:GetPos())
	object:PhysicsInit(SOLID_VPHYSICS)
	object:SetAngles(self.Owner.ghostlyEnt:GetAngles())
	object:Spawn()	
	object:Activate()
	object.owner = self.Owner
	object.hp = self.ObjectToPlace["health"]
	object.refund = math.Round(self.ObjectToPlace["cost"] / 2)
	self.Owner:SetNWInt("bb_cash", self.Owner:GetNWInt("bb_cash") - self.ObjectToPlace["cost"])
end

function SWEP:Reload()
	return
end

function SWEP:SecondaryAttack()
	if self:CanSecondaryAttack() then return end
	if SERVER then return end
	if IsValid(shopFrame) then return end
	
	self:SetNextSecondaryFire(CurTime() + 1)
	
	OpenShopMenu()
end

function SWEP:ResetSelection()
	if IsValid(self.Owner.ghostlyEnt) then self.Owner.ghostlyEnt:Remove() end
end