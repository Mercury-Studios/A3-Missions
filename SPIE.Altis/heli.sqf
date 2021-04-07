sil_Action_Fnc = {
	id = player addAction ["Harness To Ropes",{call sil_Rope_Fnc, player removeAction id;}];
};

sil_Rope_Fnc = {
	passcount = 0;
	target = player;
	[] spawn {target switchMove "passenger_bench_1_aim", 
	sleep 5, 
	[target, [0,0,0], [0,0,-1]] ropeAttachTo (ropes heli select 0), 
	target attachTo [myRope],
	if (passcount == 1) then {target ropeDetach myRope, target setPos [(getPos target) select 0, (getPos target) select 1, 30], [target, myRope] call BIS_fnc_attachToRelative};
	passcount = passcount + 1, 
	};
	target addeventHandler ["Fired", {
		state = animationState player;
		if (state == "passenger_bench_1_aim") then {
			detach target;
			target ropeDetach myRope;
			target switchMove "";
		};
	}];
};

heli addAction ["[Pilot] Deploy Ropes", {myRope = ropeCreate [vehicle player, [0,3,-1.5], 20],  
	trg = createTrigger ["EmptyDetector", position myRope]; 
	trg setTriggerArea [1.5, 1.5, 15, false]; 
	trg setTriggerActivation ["ANYPLAYER", "PRESENT", true]; 
	trg setTriggerStatements ["this", "hint 'Starting Rope Process, Shoot To Dismount!', call sil_Action_Fnc", "hint ''"];
	while {true} do {
		sleep 2, trg setPos position myRope;
	};
}];

heli addAction ["[Pilot] Cut Ropes",{ropeDestroy myRope, deleteVehicle trg}];

heli addAction ["[Pilot] Pull Ropes (18m /)",{ropeUnwind [ropes heli select 0, 3, 2]}];

heli addAction ["[Pilot] Release Ropes (18m \)",{ropeUnwind [ropes heli select 0, 3, 20]}];

heli addAction ["[Pilot] Extract Target (1 Unit)",{target moveInAny heli, ropeDestroy myRope}];