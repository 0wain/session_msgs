ConNotifyConfig = {}
ConNotifyConfig.Prefix = "My Cool Server"
ConNotifyConfig.PrefixColor = Color(216,25,25)

if SERVER then
	util.AddNetworkString("IRP_Connect")
	util.AddNetworkString("IRP_Disconnect")
	
	hook.Add("PlayerConnect", "IRP_ConnectHook", function(ply)
		net.Start("IRP_Connect")
			net.WriteString(ply)
		net.Broadcast()
	end)
	hook.Add("PlayerDisconnected", "IRP_DisconnectHook", function(ply)
		net.Start("IRP_Disconnect")
			net.WriteString(ply:Nick())
			net.WriteString(ply:SteamID())
			net.WriteTable(team.GetColor(ply:Team()))
		net.Broadcast()
	end)
end


if CLIENT then
	net.Receive("IRP_Connect", function()
		local target = net.ReadString()
		chat.AddText( ConNotifyConfig.PrefixColor, "["..ConNotifyConfig.Prefix.."] ", Color( 255, 255, 255 ), target.." has connected to the server." )
	end) 
	net.Receive("IRP_Disconnect", function()
		local target = net.ReadString()
		local targetid = net.ReadString()
		local targetcolor = net.ReadTable()
		chat.AddText( ConNotifyConfig.PrefixColor, "["..ConNotifyConfig.Prefix.."] ", Color(targetcolor.r, targetcolor.g, targetcolor.b), target, Color( 255, 255, 255 ), " has disconnected from the server. Their SteamID was: "..targetid )
	end)
end
