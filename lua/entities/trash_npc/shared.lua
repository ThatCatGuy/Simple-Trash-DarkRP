ENT.Base = "base_ai" 
ENT.Type = "ai" 
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "Trash Buyer"
ENT.Category = "Simple Trash Collection"
ENT.Spawnable = true
ENT.AdminOnly = true 

ENT.Name 	= "Trash Buyer"
ENT.Model 	= "models/Humans/Group01/male_09.mdl"
ENT.NPCType = "Sell Your Trash"

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end