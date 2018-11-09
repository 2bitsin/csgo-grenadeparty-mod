#pragma semicolon 1

#include <sourcemod>
#include <sdktools_functions>

#pragma newdecls required

//#define COMMANDS_PER_PAGE	10

public Plugin myinfo = 
{
	name = "Grenade Party",
	author = "Ikkepop",
	description = "Grenades rock!",
	version = SOURCEMOD_VERSION,
	url = "www.2bits.in"
};

public void OnPluginStart()
{
	//LoadTranslations("common.phrases");
	//LoadTranslations("adminhelp.phrases");
	//RegConsoleCmd("sm_help", HelpCmd, "Displays SourceMod commands and descriptions");
	//RegConsoleCmd("sm_searchcmd", HelpCmd, "Searches SourceMod commands");
	PrintToServer("Grenade Party!");
	HookEvent("player_spawned", Event_PlayerSpawned);
	HookEvent("player_spawn", Event_PlayerSpawned);
	CVar_Set("ammo_grenade_limit_default", 	 	100);
	CVar_Set("ammo_grenade_limit_flashbang", 	100);
	CVar_Set("ammo_grenade_limit_total",		1000);

}

public void CVar_Set(const char[] key, int val)
{
	ConVar theVar = FindConVar(key);
	if (!theVar)
	{
		theVar = CreateConVar(key, "100", key, FCVAR_NONE, false, 0, false, 0);
	}
	
	theVar.SetInt(val);
}

public Action Event_PlayerSpawned(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	int teamid = GetClientTeam(client);
	PrintToServer("GrenadeParty equipping! [uid = %d, cid = %d, tid = %d]", userid, client, teamid);
	PrintToConsole(client, "Giving you grenades!");
	for (int i = 0; i < 10; ++i) 
	{
		GivePlayerItem(client, "weapon_flashbang");
		GivePlayerItem(client, "weapon_hegrenade");
		GivePlayerItem(client, "weapon_smokegrenade");
		GivePlayerItem(client, "weapon_decoy");
		
		if (teamid != 2)
		{
			GivePlayerItem(client, "weapon_incgrenade");
		}
		else		
		{	
			GivePlayerItem(client, "weapon_molotov");
		}
	}
	//GivePlayerItem(client, "weapon_c4");	
	return Plugin_Handled;	
}