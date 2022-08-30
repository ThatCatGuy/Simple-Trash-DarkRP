include('shared.lua')

surface.CreateFont("trash_title",{
	font = "roboto",
	size = 26
})

local color_white = Color(250, 250, 250)
local color_black = Color(0, 0, 0)

function ENT:Draw()
	self.Entity:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local distance = pos:Distance(LocalPlayer():GetPos())
	
	if distance > 400 then return end
	color_white.a = 400 - distance
	color_black.a = 400 - distance
	
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)	
	cam.Start3D2D(pos + ang:Up() + ang:Right() * -35, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.15)
		if LocalPlayer():Team() != TEAM_HOBO then
			draw.SimpleTextOutlined("Change to Hobo to collect trash.", "trash_title", 0, math.sin(CurTime() * 2) * 20 + 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)
		elseif self:GetFull() then
			draw.SimpleTextOutlined("Press E to collect trash.", "trash_title", 0, math.sin(CurTime() * 2) * 20 + 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)
		else
			draw.SimpleTextOutlined("Please Wait... Refilling", "trash_title", 0, math.sin(CurTime() * 2) * 20 + 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)
		end
	cam.End3D2D()
	old_y = new_y
end