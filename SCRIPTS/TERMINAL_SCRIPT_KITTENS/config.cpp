class CfgPatches
{
	class terminal_script_kittens
	{
		units[]={};
		weapons[]={};
		version=1;
		requiredAddons[]={};
		author="TerminalHunter";
		fileName="terminal_script_kittens.pbo";
	};
};
class CfgFunctions
{
	class terminal_script_kittens
	{
		class functions
		{
			file="terminal_script_kittens\functions";
			class postInit
			{
				postInit=1;
			};
		};
	};
};