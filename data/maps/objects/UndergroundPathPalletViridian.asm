UndergroundPathPalletViridian_Object:
	db $1 ; border block

	def_warp_events
	warp_event  5,  4, UNDERGROUND_PATH_VIRIDIANCITY, 3
	warp_event  2, 41, UNDERGROUND_PATH_PALLETTOWN, 3

	def_bg_events

	def_object_events

	def_warps_to UNDERGROUND_PATH_PALLETTOWN_VIRIDIANCITY
