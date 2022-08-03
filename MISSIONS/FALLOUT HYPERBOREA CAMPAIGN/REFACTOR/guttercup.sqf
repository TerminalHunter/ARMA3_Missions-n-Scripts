//baseMechazawa

baseMechazawa addAction ["Break 100 Caps",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,1,"AM_BCap100"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_BCap100";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    _caller addItem "AM_BCap10";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],6,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Break 10 Caps",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,1,"AM_BCap10"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_BCap10";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    _caller addItem "AM_BCap";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],5,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Break $100 NCR",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,1,"AM_bill100"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_bill100";
    _caller addItem "AM_bill20";
    _caller addItem "AM_bill20";
    _caller addItem "AM_bill20";
    _caller addItem "AM_bill20";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],4,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Break $20 NCR",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,1,"AM_bill20"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_bill20";
    _caller addItem "AM_bill5";
    _caller addItem "AM_bill5";
    _caller addItem "AM_bill5";
    _caller addItem "AM_bill5";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["Please place all items in backpack."] remoteExec ["shorterHint",_caller,false];
  };
},[],3,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Make 100 Caps",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,10,"AM_BCap10"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller removeItemFromBackpack "AM_BCap10";
    _caller addItem "AM_BCap100";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],2,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Make 10 Caps",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,10,"AM_BCap"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller removeItemFromBackpack "AM_BCap";
    _caller addItem "AM_BCap10";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],1,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Make $100 NCR",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,4,"AM_bill20"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_bill20";
    _caller removeItemFromBackpack "AM_bill20";
    _caller removeItemFromBackpack "AM_bill20";
    _caller removeItemFromBackpack "AM_bill20";
    _caller addItem "AM_bill100";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],0,true,true,"","true",10,false,"",""];

baseMechazawa addAction ["Make $20 NCR",{
  params ["_target", "_caller", "_actionId", "_arguments"];
  if ([_caller,4,"AM_bill5"] call checkBackpackFor) then {
    _caller removeItemFromBackpack "AM_bill5";
    _caller removeItemFromBackpack "AM_bill5";
    _caller removeItemFromBackpack "AM_bill5";
    _caller removeItemFromBackpack "AM_bill5";
    _caller addItem "AM_bill20";
    ["DISPENSING. Thank you for using changeAUTHNAME::Bittyup_Guttercup"] remoteExec ["shorterHint",_caller,false];
  } else {
    ["ERROR: Please place all items in backpack"] remoteExec ["shorterHint",_caller,false];
  };
},[],-1,true,true,"","true",10,false,"",""];

checkBackpackFor = {
  params ["_player","_numberOfItemToCheckFor","_itemToCheckFor"];
  _backpackContainer = getMagazineCargo backpackContainer _player;
  _listOfItems = _backpackContainer select 0;
  _countOfItems = _backpackContainer select 1;
  _return = false;
  {
      if (_x == _itemToCheckFor) then {
        if ((_countOfItems select _forEachIndex) >= _numberOfItemToCheckFor) then {
          _return = true;
        };
      };
  } forEach _listOfItems;
  _return
};
