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


//public Action HelpCmd(int client, int args)
//{
//	char arg[64], CmdName[20];
//	int PageNum = 1;
//	bool DoSearch;
//
//	GetCmdArg(0, CmdName, sizeof(CmdName));
//
//	if (GetCmdArgs() >= 1)
//	{
//		GetCmdArg(1, arg, sizeof(arg));
//		StringToIntEx(arg, PageNum);
//		PageNum = (PageNum <= 0) ? 1 : PageNum;
//	}
//
//	DoSearch = (strcmp("sm_help", CmdName) == 0) ? false : true;
//
//	if (GetCmdReplySource() == SM_REPLY_TO_CHAT)
//	{
//		ReplyToCommand(client, "[SM] %t", "See console for output");
//	}
//
//	char Name[64];
//	char Desc[255];
//	char NoDesc[128];
//	int Flags;
//	Handle CmdIter = GetCommandIterator();
//
//	FormatEx(NoDesc, sizeof(NoDesc), "%T", "No description available", client);
//
//	if (DoSearch)
//	{
//		int i = 1;
//		while (ReadCommandIterator(CmdIter, Name, sizeof(Name), Flags, Desc, sizeof(Desc)))
//		{
//			if ((StrContains(Name, arg, false) != -1) && CheckCommandAccess(client, Name, Flags))
//			{
//				PrintToConsole(client, "[%03d] %s - %s", i++, Name, (Desc[0] == '\0') ? NoDesc : Desc);
//			}
//		}
//
//		if (i == 1)
//		{
//			PrintToConsole(client, "%t", "No matching results found");
//		}
//	} else {
//		PrintToConsole(client, "%t", "SM help commands");		
//
//		/* Skip the first N commands if we need to */
//		if (PageNum > 1)
//		{
//			int i;
//			int EndCmd = (PageNum-1) * COMMANDS_PER_PAGE - 1;
//			for (i=0; ReadCommandIterator(CmdIter, Name, sizeof(Name), Flags, Desc, sizeof(Desc)) && i<EndCmd; )
//			{
//				if (CheckCommandAccess(client, Name, Flags))
//				{
//					i++;
//				}
//			}
//
//			if (i == 0)
//			{
//				PrintToConsole(client, "%t", "No commands available");
//				delete CmdIter;
//				return Plugin_Handled;
//			}
//		}
//
//		/* Start printing the commands to the client */
//		int i;
//		int StartCmd = (PageNum-1) * COMMANDS_PER_PAGE;
//		for (i=0; ReadCommandIterator(CmdIter, Name, sizeof(Name), Flags, Desc, sizeof(Desc)) && i<COMMANDS_PER_PAGE; )
//		{
//			if (CheckCommandAccess(client, Name, Flags))
//			{
//				i++;
//				PrintToConsole(client, "[%03d] %s - %s", i+StartCmd, Name, (Desc[0] == '\0') ? NoDesc : Desc);
//			}
//		}
//
//		if (i == 0)
//		{
//			PrintToConsole(client, "%t", "No commands available");
//		} else {
//			PrintToConsole(client, "%t", "Entries n - m in page k", StartCmd+1, i+StartCmd, PageNum);
//		}
//
//		/* Test if there are more commands available */
//		if (ReadCommandIterator(CmdIter, Name, sizeof(Name), Flags, Desc, sizeof(Desc)) && CheckCommandAccess(client, Name, Flags))
//		{
//			PrintToConsole(client, "%t", "Type sm_help to see more", PageNum+1);
//		}
//	}
//
//	delete CmdIter;
//
//	return Plugin_Handled;
//}
//