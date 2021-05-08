AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.Model = "models/props_borealis/bluebarrel001.mdl"
ENT.Material = "models/props_combine/com_shield001a"

ENT.CoreHealth = 500

function ENT:Initialize()
	if CLIENT then return end
	self:SetModel(self.Model)
	self:SetMaterial(self.Material)
	self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:GetCoreHealth()
	return self.CoreHealth
end

function ENT:SetCoreHealth(newHealth)
	self.CoreHealth = newHealth
end

function ENT:CheckStatus()
	if self.CoreHealth <= 0 then
		self:Remove()
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("Red Core is destroyed, Blue team wins!")
		end
	end	
end

function ENT:TakeCoreDamage(dmg)
	self.CoreHealth = self.CoreHealth - dmg
	self:CheckStatus()
end

local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		-- Flip the angle 180 degrees around the UP axis
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end

	cam.Start3D2D( pos, ang, scale )
		-- Actually draw the text. Customize this to your liking.
		draw.DrawText( text, "Default", 0, -25, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	-- Draw the model
	self:DrawModel()

	-- The text to display
	local text = "Red Core"

	-- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 2 )

	-- The angle
	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	-- Draw front
	Draw3DText( pos, ang, 1, text, false )
	-- DrawDraw3DTextback
	Draw3DText( pos, ang, 1, text, true )
end

