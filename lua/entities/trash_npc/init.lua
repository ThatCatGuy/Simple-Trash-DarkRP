AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

function ENT:Initialize()
	self:SetModel(self.Model)
	self:DrawShadow(false)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetMaxYawSpeed(90)
end

local SimpleTrashRandomJobs = {"Hobo"} // Job that can do this Default is Hobo.
local simpletrash_sellprice 	= GetConVar( "simpletrash_sellprice" ):GetInt()

function ENT:AcceptInput(name, activator, caller, data)
	if caller.NPCNextUse and caller.NPCNextUse > CurTime() then
		return
	end
	caller.NPCNextUse = CurTime() + 1
	if name == "Use" and IsValid(caller) and caller:IsPlayer() then
		if not table.HasValue(SimpleTrashRandomJobs, team.GetName(caller:Team())) then return end
		  if caller.Trash and caller.Trash > 0 then
		  	local TotalTrash = caller.Trash
		  	local TrashReward = simpletrash_sellprice
		  	local FinalMoney = TotalTrash*TrashReward
		  	SimpleTrashSold(caller, TotalTrash, FinalMoney)
			caller.Trash = 0
			caller:addMoney(FinalMoney)
		else
            SimpleTrashRandomSaying(caller)
        end
	end
end