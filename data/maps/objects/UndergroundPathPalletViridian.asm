	object_const_def
	const_export UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY

UndergroundPathPalletViridian_Object:
	db $1 ; border block

	def_warp_events
	warp_event 5,  4, UNDERGROUND_PATH_VIRIDIANCITY, 3
	warp_event 6, 57, UNDERGROUND_PATH_PALLETTOWN, 3

	def_bg_events

	def_object_events
	object_event  2, 13, SPRITE_ROCKET, STAY, UP, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY

	def_warps_to UNDERGROUND_PATH_PALLETTOWN_VIRIDIANCITY
