PewterSpeechHouse_Script:
	jp EnableAutoTextBoxDrawing

PewterSpeechHouse_TextPointers:
	def_text_pointers
	dw_const PewterSpeechHouseGamblerText,   TEXT_PEWTERSPEECHHOUSE_GAMBLER
	dw_const PewterSpeechHouseYoungsterText, TEXT_PEWTERSPEECHHOUSE_YOUNGSTER

PewterSpeechHouseGamblerText:
	text_far _PewterSpeechHouseGamblerText
	text_end

PewterSpeechHouseYoungsterText:
	text_far _PewterSpeechHouseYoungsterText
	text_end
