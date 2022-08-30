AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local SimpleTrashRandomJobs = {"Hobo"} // Job that can do this Default is Hobo.
local simpletrash_cooldownmin 	= GetConVar( "simpletrash_cooldownmin" ):GetInt()
local simpletrash_cooldownmax 	= GetConVar( "simpletrash_cooldownmax" ):GetInt()
local simpletrash_amountmin 	= GetConVar( "simpletrash_amountmin" ):GetInt()
local simpletrash_amountmax 	= GetConVar( "simpletrash_amountmax" ):GetInt()

function ENT:Initialize()
	self:SetModel("models/props_trainstation/trashcan_indoor001a.mdl")
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow(false)
	self:SetFull(true)
   	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
end

function ENT:OnRemove( )
	timer.Destroy( tostring(self:GetPos()).."SimpleTrash.CanSpawn" )
end

function ENT:AcceptInput(name, activator, caller, data)
	if caller.NPCNextUse and caller.NPCNextUse > CurTime() then
		return
	end
	caller.NPCNextUse = CurTime() + 1
		if table.HasValue(SimpleTrashRandomJobs, team.GetName(caller:Team())) then
			if timer.Exists( tostring(self:GetPos()).."SimpleTrash.CanSpawn" ) then return end
				local TrashCoolDown = math.Round(math.random(simpletrash_cooldownmin, simpletrash_cooldownmax))
				local TrashAmount 	= math.Round(math.random(simpletrash_amountmin, simpletrash_amountmax))
				SimpleTrashPickUp(caller, TrashAmount)
				self:SetFull(false)
				self:SetModel("models/props_trainstation/trashcan_indoor001b.mdl")
			timer.Create( tostring(self:GetPos()).."SimpleTrash.CanSpawn", TrashCoolDown, 1, function() 
				self:SetFull(true)
				self:SetModel("models/props_trainstation/trashcan_indoor001a.mdl")
				self:SetFull(true)
			end)
		else
			SimpleTrashWrongJob(caller)
		end
end