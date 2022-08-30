include('shared.lua')

surface.CreateFont("trash_npc_title",{
	font = "Roboto",
	weight = 500,
	size = 75
})

surface.CreateFont("trash_npc_type",{
	font = "roboto",
	size = 26
})

local color_white = Color(250, 250, 250)
local color_black = Color(0, 0, 0)

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local distance = pos:Distance(LocalPlayer():GetPos())
	
	if distance > 400 then return end
	color_white.a = 400 - distance
	color_black.a = 400 - distance

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)	
	cam.Start3D2D(pos + ang:Up() + ang:Right() * -70, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
			draw.SimpleTextOutlined(self.Name, "trash_npc_title", 0, math.sin(CurTime() * 2) * 20 + -130, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)
			if self.NPCType then draw.SimpleTextOutlined(self.NPCType, "trash_npc_type", 0, math.sin(CurTime() * 2) * 20 + -70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black) end
	cam.End3D2D()	
end