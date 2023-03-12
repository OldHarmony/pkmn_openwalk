Route20Gate_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  5, LAST_MAP, 3
	warp_event  3,  5, LAST_MAP, 3
	warp_event  7,  2, LAST_MAP, 4
	warp_event  7,  3, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2 ; person

	def_warps_to ROUTE_20_GATE
