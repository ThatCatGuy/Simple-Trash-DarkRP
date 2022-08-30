util.AddNetworkString("SimpleTrash.Notify")
local function Notify(ply, msg)
	net.Start("SimpleTrash.Notify")
		net.WriteString(msg)
	net.Send(ply)
end

util.AddNetworkString("SimpleTrash.NPCNotify")
local function NPCNotify(ply, msg)
	net.Start("SimpleTrash.NPCNotify")
		net.WriteString(msg)
	net.Send(ply)
end

CreateConVar( "simpletrash_sellprice", 200, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simpletrash_cooldownmin", 60, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simpletrash_cooldownmax", 120, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simpletrash_amountmin", 1, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simpletrash_amountmax", 5, FCVAR_SERVER_CAN_EXECUTE )

local Sayings = {
	"Bring me some trash",
	"Collect that trash from the bins and bring it to me",
	"Where is the trash at ?"
}

function SimpleTrashRandomSaying(ply)
	local msg = Sayings[math.random(#Sayings)]
	NPCNotify(ply, msg)
end

function SimpleTrashWrongJob(ply)
	Notify(ply, "You need to be a Hobo to collect trash!")
end

function SimpleTrashSold(ply, amount, money)
	NPCNotify(ply, "You just sold " .. amount .. " of trash for " .. DarkRP.formatMoney(money) .. "!")
end

function SimpleTrashPickUp(ply, amount)
	ply.Trash = (ply.Trash or 0) + (amount and amount or 1)
	Notify(ply, "+" .. (amount and amount or 1) .. " pieces of trash (" .. ply.Trash .. ")")
end

local function Fail(ply)
	if ply.Trash and ply.Trash > 0 then
		ply.Trash = 0
		Notify(ply, "You lost all of your trash (" .. ply.Trash .. ").")
	end
end

local function SimpleTrashCheck(ply)
	ply.Trash = (ply.Trash or 0)
	if ply.Trash == 0 then Notify(ply, "You don't have any trash.") return end
	Notify(ply, "You have " .. ply.Trash .. " pieces of trash.")
end

hook.Add( "PlayerSay", "SimpleTrashCheck", function( ply, text  )
    if  ( string.lower( text ) == "/trash" or string.lower( text ) == "!trash" ) then
	     SimpleTrashCheck(ply)
	    return ""
	end
end)

hook.Add("PlayerDeath", "SimpleTrash.RemoveTrash", Fail)
hook.Add("OnPlayerChangedTeam", "SimpleTrash.RemoveTrash", Fail)

// NPC Spawn Functions
local map = string.lower( game.GetMap() )
//##### Save the Ents ##############################################################
local function SimpleTrashEntsSave(ply)
    if ply:IsSuperAdmin() then   
        local trashents = {}
        for k,v in pairs( ents.FindByClass("trash_*") ) do
            trashents[k] = { type = v:GetClass(), pos = v:GetPos(), ang = v:GetAngles() }
        end	
        local convert_data = util.TableToJSON( trashents )		
        file.Write( "simpletrash/trashents_" .. map .. ".txt", convert_data )
        NPCNotify(ply, "Trash Ent Locations Saved for map " .. map)  
    end
end
concommand.Add("simpletrash_saveents", SimpleTrashEntsSave)
 
//##### Delete the Ents ##############################################################
local function SimpleTrashEntsDelete(ply)
    if ply:IsSuperAdmin() then
    	for k,v in pairs( ents.FindByClass("trash_*") ) do
            v:Remove()
        end
        file.Delete( "simpletrash/trashents_" .. map .. ".txt" )
        NPCNotify(ply, "Trash Ent Locations Deleted from map " .. map)
    end    
end
concommand.Add("simpletrash_removeents", SimpleTrashEntsDelete)

//##### Load the Ents ##############################################################
local function SimpleTrashEntsLoad(ply)
	if ply:IsSuperAdmin() then
		if not file.IsDir( "simpletrash", "DATA" ) then
        	file.CreateDir( "simpletrash", "DATA" )
    	end
		if not file.Exists("simpletrash/trashents_" .. map .. ".txt","DATA") then return end
		for k,v in pairs( ents.FindByClass("trash_*") ) do
            v:Remove()
        end	
		local ImportData = util.JSONToTable(file.Read("simpletrash/trashents_" .. map .. ".txt","DATA"))
	    	for k, v in pairs(ImportData) do
	        local ent = ents.Create( v.type )
	        ent:SetPos( v.pos )
	        ent:SetAngles( v.ang )
	        ent:Spawn()
		end
	end
end
concommand.Add("simpletrash_respawnents", SimpleTrashEntsLoad)

//##### Autospawn the Ents ##############################################################
local function SimpleTrashNPCInit()
    if not file.IsDir( "simpletrash", "DATA" ) then
        file.CreateDir( "simpletrash", "DATA" )
    end
	if not file.Exists("simpletrash/trashents_" .. map .. ".txt","DATA") then return end
	local ImportData = util.JSONToTable(file.Read("simpletrash/trashents_" .. map .. ".txt","DATA"))
    	for k, v in pairs(ImportData) do
        local ent = ents.Create( v.type )
        ent:SetPos( v.pos )
        ent:SetAngles( v.ang )
        ent:Spawn()
	end
end
hook.Add( "InitPostEntity", "SimpleTrashNPCInit", SimpleTrashNPCInit )