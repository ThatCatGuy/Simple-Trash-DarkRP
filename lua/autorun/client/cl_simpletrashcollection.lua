local function Notify(msg)
	chat.AddText(Color(181, 181, 181), "Trash | ", Color(240, 240, 240), msg)
end

local function NPCNotify(msg)
	chat.AddText(Color(181, 181, 181), "Trash Buyer | ", Color(240, 240, 240), msg)
end

net.Receive("SimpleTrash.Notify", function()
	Notify(net.ReadString())
end)

net.Receive("SimpleTrash.NPCNotify", function()
	NPCNotify(net.ReadString())
end)