Route20_Object:
	db $43 ; border block

	def_warp_events
	warp_event 48,  5, SEAFOAM_ISLANDS_1F, 1
	warp_event 58,  9, SEAFOAM_ISLANDS_1F, 3
	warp_event 53,  5, ROUTE_20_GATE, 1
	warp_event 58,  4, ROUTE_20_GATE, 3

	def_bg_events
	bg_event 51,  7, 11 ; Route20Text11
	bg_event 57, 11, 12 ; Route20Text12

	def_object_events
	object_event 87,  9, SPRITE_SWIMMER, STAY, UP, 1, OPP_SWIMMER, 9
	object_event 68, 11, SPRITE_SWIMMER, STAY, UP, 2, OPP_BEAUTY, 15
	object_event 45, 11, SPRITE_SWIMMER, STAY, DOWN, 3, OPP_BEAUTY, 6
	object_event 56, 14, SPRITE_SWIMMER, STAY, RIGHT, 4, OPP_JR_TRAINER_F, 24
	object_event 27, 12, SPRITE_SWIMMER, STAY, DOWN, 5, OPP_SWIMMER, 10
	object_event 87, 13, SPRITE_SWIMMER, STAY, UP, 6, OPP_SWIMMER, 11
	object_event 20,  9, SPRITE_COOLTRAINER_M, STAY, UP, 7, OPP_BIRD_KEEPER, 11
	object_event 13, 10, SPRITE_SWIMMER, STAY, UP, 8, OPP_BEAUTY, 7
	object_event  9,  7, SPRITE_SWIMMER, STAY, DOWN, 9, OPP_JR_TRAINER_F, 16
	object_event 39, 11, SPRITE_SWIMMER, STAY, UP, 10, OPP_BEAUTY, 8

	def_warps_to ROUTE_20
