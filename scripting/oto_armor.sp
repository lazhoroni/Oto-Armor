#include <sourcemod>
#include <sdktools>
#include <multicolors>
#pragma tabsize 0
#pragma semicolon 1
int g_iRound;
Handle g_hCvRestart;

public void OnPluginStart()
{
	g_hCvRestart = FindConVar("mp_restartgame");
	HookEvent("round_start", fwRoundStart, EventHookMode_PostNoCopy);
	HookConVarChange(g_hCvRestart, fwCvarChange);
	LoadTranslations("oto_armor.phrases");
}

public void OnMapStart()
{
	g_iRound = 0;
}

public void OnMapEnd()
{
	g_iRound = 0;
}

public void fwCvarChange( Handle hCvar, const char[] sOldValue, const char[] sNewValue )
{
	if( StringToInt(sNewValue) > 0 ) g_iRound = 0;
}

public Action fwRoundStart( Handle hEvent, const char[] sName, bool dontBroadcast )
{
	if (GameRules_GetProp("m_bWarmupPeriod") == 0)
	{
		g_iRound++;
		if(g_iRound != 1 && g_iRound != 2 && g_iRound != 3 && g_iRound != 16 && g_iRound != 17 && g_iRound != 18)
		{
			for (new i = 1; i <= MaxClients; i++)
			if(IsValidClient(i))
			{
				SetEntProp(i, Prop_Send, "m_bHasHelmet", 100);
				SetEntProp(i, Prop_Send, "m_ArmorValue", 100);
				CPrintToChat(i, "%t", "DigerRoundlar");
			}
		}
		else
		{
			for (new i = 1; i <= MaxClients; i++)
			if(IsValidClient(i))
			CPrintToChat(i, "%t", "Ilk3Round");
		}
	}
}

bool IsValidClient(client)
{
	return 1 <= client <= MaxClients && IsClientInGame(client) && !IsFakeClient(client);
}
