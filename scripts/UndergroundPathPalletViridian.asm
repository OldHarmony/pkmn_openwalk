UndergroundPathPalletViridian_Script:
	jp EnableAutoTextBoxDrawing

UndergroundPathPalletViridian_TextPointers:
	def_text_pointers
	dw_const UndergroundPathPalletViridian_RocketGuyTextScript, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY

UndergroundPathPalletViridian_RocketGuyTextScript:
	text_asm
	ld hl, .UndergroundPathPalletViridian_RocketGuyText2
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .text_script_end
	ld hl, .UndergroundPathPalletViridian_RocketGuyText1
	call PrintText
.text_script_end
	jp TextScriptEnd

.UndergroundPathPalletViridian_RocketGuyText1:
	text_far _UndergroundPathPalletViridian_RocketGuyText1
	text_end

.UndergroundPathPalletViridian_RocketGuyText2:
	text_far _UndergroundPathPalletViridian_RocketGuyText2
	text_end
