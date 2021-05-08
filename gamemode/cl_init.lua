include("shared.lua")
include("cl_hud.lua")


function OpenShopMenu()

	shopFrame = vgui.Create("DFrame")
	shopFrame:SetTitle("Entity Shop")
	shopFrame:SetSize(ScrW() / 1.5, ScrH() / 1.75)
	shopFrame:Center()
	shopFrame:MakePopup()
	shopFrame:SetDraggable(false)
	
	local shopScroll = vgui.Create("DScrollPanel", shopFrame)
	shopScroll:Dock(FILL)
	
	local shopList = vgui.Create("DIconLayout", shopScroll)
	shopList:Dock(FILL)
	shopList:SetSpaceY(5)
	shopList:SetSpaceX(5)
	
	for i, item in pairs(GAMEMODE.ShopItems) do
		local itemPnl = shopList:Add("DPanel")
		itemPnl:SetSize(128, 128)

		local itemIcon = vgui.Create("SpawnIcon", itemPnl)
		itemIcon:SetModel(item["model"])
		itemIcon:SetSize(128, 128)
		itemIcon:SetToolTip(item["name"] .. "\nCOST: " .. item["cost"])
		
		itemIcon.DoClick = function()
			net.Start("bb_updatetool")
				net.WriteInt(i, 8)
			net.SendToServer()
		end
	end
end