ms_fnc_addUnitsToEH = {_x addMPEventHandler ["MPHit",{ 
_unit = (_this select 0); 
_shooter = (_this select 3);
_weapon = currentWeapon _shooter; 
tazerman = _shooter;
tazedman = _unit;
distance11 = player distance tazedman; 
if (_weapon == "hgun_P07_F" && distance11 <= 10) then
{ 
        [] spawn {
            isTazed = true;
            tazedman setDamage 0; 
            tazedman addForce [[150,0,0],[0,0,3]]; 
            tazedman say3D "tasersfx"; 
            tazerman say3D "tasershot"; 
            tazedman allowDamage false; 
            sleep 1.5;
            tazedman setUnconscious true;
            sleep 7.5; 
            tazedman setUnconscious false; 
            tazedman setDamage 0; 
            tazedman allowDamage true;
            tazedman setHit ["legs", 1]; 
            isTazed = false; 
            }; 
        } else {
tazedman setDamage 0;
tazedman setHit ["legs", 1];
};
}];
};
