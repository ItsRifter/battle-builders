surface.CreateFont( "bb_hudfont", {
	font = "Arial",
	extended = false,
	size = 56,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

net.Receive("bb_timerstart", function()
	timer.Create("bb_timer", 180, 1, function() end)
end)

net.Receive("bb_timerend", function()
	timer.Remove("bb_timer")
end)

hook.Add("HUDPaint", "bb_hud", function()
	
	surface.SetFont("bb_hudfont")
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( ScrW() / 1.35, ScrH() / 1.08)
	
	surface.DrawText("Cash: " .. tostring(LocalPlayer():GetNWInt("bb_cash")))
	
	if timer.Exists("bb_timer") then
		surface.SetTextColor( 255, 255, 255 )
		surface.SetTextPos( ScrW() / 1.40, ScrH() / 1.16)
		surface.DrawText("Time Left: " .. tostring(math.Round(timer.TimeLeft("bb_timer"))))
	end
end)