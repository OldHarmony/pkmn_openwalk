	object_const_def
	const_export VIRIDIANCITY_YOUNGSTER1
	const_export VIRIDIANCITY_GAMBLER1
	const_export VIRIDIANCITY_YOUNGSTER2
	const_export VIRIDIANCITY_GIRL
	const_export VIRIDIANCITY_OLD_MAN_SLEEPY
	const_export VIRIDIANCITY_FISHER
	const_export VIRIDIANCITY_OLD_MAN

ViridianCity_Object:
	db $f ; border block

	def_warp_events
	warp_event 23, 25, VIRIDIAN_POKECENTER, 1
	warp_event 29, 19, VIRIDIAN_MART, 1
	warp_event 21, 15, VIRIDIAN_SCHOOL_HOUSE, 1
	warp_event 21,  9, VIRIDIAN_NICKNAME_HOUSE, 1
	warp_event 32,  7, VIRIDIAN_GYM, 1
	warp_event 11,  17, UNDERGROUND_PATH_VIRIDIANCITY, 1

	def_bg_events
	bg_event 17, 17, TEXT_VIRIDIANCITY_SIGN
	bg_event 19,  1, TEXT_VIRIDIANCITY_TRAINER_TIPS1
	bg_event 21, 29, TEXT_VIRIDIANCITY_TRAINER_TIPS2
	bg_event 30, 19, TEXT_VIRIDIANCITY_MART_SIGN
	bg_event 24, 25, TEXT_VIRIDIANCITY_POKECENTER_SIGN
	bg_event 27,  7, TEXT_VIRIDIANCITY_GYM_SIGN

	def_object_events
	object_event 13, 20, SPRITE_YOUNGSTER, WALK, ANY_DIR, TEXT_VIRIDIANCITY_YOUNGSTER1
	object_event 30,  8, SPRITE_GAMBLER, STAY, NONE, TEXT_VIRIDIANCITY_GAMBLER1
	object_event 30, 25, SPRITE_YOUNGSTER, WALK, ANY_DIR, TEXT_VIRIDIANCITY_YOUNGSTER2
	object_event 17,  9, SPRITE_GIRL, STAY, RIGHT, TEXT_VIRIDIANCITY_GIRL
	object_event 18,  9, SPRITE_GAMBLER_ASLEEP, STAY, NONE, TEXT_VIRIDIANCITY_OLD_MAN_SLEEPY
	object_event  6, 23, SPRITE_FISHER, STAY, DOWN, TEXT_VIRIDIANCITY_FISHER
	object_event 17,  5, SPRITE_GAMBLER, WALK, LEFT_RIGHT, TEXT_VIRIDIANCITY_OLD_MAN

	def_warps_to VIRIDIAN_CITY
