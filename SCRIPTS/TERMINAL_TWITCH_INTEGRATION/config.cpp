class CfgPatches
{
	class terminal_twitch_integration
	{
		units[]={};
		weapons[]={};
		version=1;
		requiredAddons[]={};
		author="TerminalHunter";
		fileName="terminal_twitch_integration.pbo";
	};
};
class CfgFunctions
{
	class terminal_twitch_integration
	{
		class functions
		{
			file="terminal_twitch_integration\functions";
			class postInit
			{
				postInit=1;
			};
		};
	};
};