_UndergroundPathPalletViridian_RocketGuyText1::
    text "Hey der Boss hat"
    line "gesagt, hier darf"
    cont "niemand durch!"
    done

_UndergroundPathPalletViridian_RocketGuyText2::
    text "Ich habe ja so"
	line "kein Bock mehr,"
	cont "auf das hier"
	cont "...."
	
	para "Hey du!"
	para "Ja du!"
	
	para "Ich habe hier so"
	line "nen Vieh. Ich"
	cont "glaub zwar nicht,"
	cont "dass es ein"
	cont "#MON ist, auch"
	cont "weil mein #DEX"
	cont "keine Infos hat."

	para "Hey, wenn du es"
	line "mir abkaufst,"
	cont "kann ich hier"
	cont "endlich weg!"
	cont "Willst du es für"
	cont "¥@"
	text_bcd wPlayerMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text " haben?"
	done
