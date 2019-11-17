[
	QGVAR(allowVehicleEnvelope), 
	"CHECKBOX", 
	[
		localize LSTRING(allowVehicleEnvelope_displayName), 
		localize LSTRING(allowVehicleEnvelope_tooltip)
	], 
	localize LSTRING(settingCategory), 
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(shortEnvelopeDigTime), 
	"SLIDER", 
	localize LSTRING(ShortEnvelopeDigTime), 
	localize LSTRING(settingCategory), 
	[5, 300, 20, 0]
] call CBA_Settings_fnc_init;