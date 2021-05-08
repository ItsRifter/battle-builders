function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/kleiner.mdl")
	ply:SetNWInt("bb_cash", 500)

	ply:Give("weapon_bb_constructor")
	ply:Give("weapon_bb_deconstructor")
end

function GM:PlayerShouldTakeDamage(ply, att)
	if not att:IsPlayer() then return true end
	
	return att:Team() ~= ply:Team()
end

function GM:DoPlayerDeath(ply, att, dmgInfo)
	ply:CreateRagdoll()
	if att:IsPlayer() then
		att:SetNWInt("bb_cash", att:GetNWInt("bb_cash") + 50)
	end
end

hook.Add("PlayerSay", "bb_chatcmds", function(ply, text)
	if text == "!joinred" then
		ply:SetPlayerColor(Vector(1, 0, 0))
		ply:SetTeam(TEAM_RED)
		return ""
	end
	
	if text == "!joinblue" then
		ply:SetPlayerColor(Vector(0, 0, 1))
		ply:SetTeam(TEAM_BLUE)
		return ""
	end
	
	if text == "!joinmadii" then
		ply:SetPlayerColor(Vector(1, 0.1, 0.7))
		ply:SetTeam(TEAM_BLUE)
		return ""
	end
	
	if text == "!begintimer" then
		net.Start("bb_timerstart")
		net.Broadcast()
	end
	
	if text == "!stoptimer" then
		net.Start("bb_timerend")
		net.Broadcast()
	end
end)

hook.Add("EntityTakeDamage", "bb_coreDMG", function(target, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	if target:IsPlayer() then return end
	
	if target:GetClass() == "bb_coreblue" or target:GetClass() == "bb_corered" then
		target:TakeCoreDamage(dmgInfo:GetDamage())
	else
		target.hp = target.hp - dmgInfo:GetDamage()
		if att:IsPlayer() then
			att:SetNWInt("bb_cash", att:GetNWInt("bb_cash") + math.Round(dmgInfo:GetDamage() / 2))
		end
	
		if target.hp <= 0 then
			target:Remove()
		end
	end
end)