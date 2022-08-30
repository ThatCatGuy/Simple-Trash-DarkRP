ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Trash Can"
ENT.Author = "ThatCatGuy"
ENT.Contact = "ThatCatGuy"
ENT.Purpose = ""
ENT.Category = "Simple Trash Collection"
ENT.Freeze = true
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Full")
end