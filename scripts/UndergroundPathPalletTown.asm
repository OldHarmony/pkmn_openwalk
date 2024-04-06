UndergroundPathPalletTown_Script:
;	ld a, PALLETTOWN
;	ld [wLastMap], a
	jp EnableAutoTextBoxDrawing

UndergroundPathPalletTown_TextPointers:
;	dw UndergroundPathPalletTownText1
;
;UndergroundPathPalletTownText1:
;	text_far _UndergroundPathPalletTownText1
	text_end
