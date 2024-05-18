UndergroundPathPalletViridian_Script:
	call EnableAutoTextBoxDrawing
	ld hl, UndergroundPathPalletViridian_ScriptPointers
	ld a, [wUndergroundPathPalletViridianCurScript]
	jp CallFunctionInTable

UndergroundPathPalletViridian_ScriptPointers:
	def_script_pointers
	dw_const UndergroundPathPalletViridianDefaultScript, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_DEFAULT

UndergroundPathPalletViridianDefaultScript:
	ld a, [wPartyCount]
	cp $00
	ret nz
	ld hl, UndergroundPathPalletViridian_RocketGuy_sees_Player_Coords
	call ArePlayerCoordsInArray
	ret nc
	ld a, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_NOPKMN
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

UndergroundPathPalletViridian_RocketGuy_sees_Player_Coords:
if DEF(_DEBUG)
	dbmapcoord 2, 10
	dbmapcoord 3, 10
	dbmapcoord 4, 10
	dbmapcoord 5, 10
endc
	dbmapcoord 5, 11
	dbmapcoord 5, 12
	dbmapcoord 5, 13
	db -1 ; end

UndergroundPathPalletViridian_TextPointers:
	def_text_pointers
	dw_const UndergroundPathPalletViridian_RocketGuyTextScript, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	dw_const UndergroundPathPalletViridian_RocketGuyText1, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_NOPKMN

UndergroundPathPalletViridian_RocketGuyTextScript:
	text_asm
	ld hl, UndergroundPathPalletViridian_RocketGuyText2
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .text_script_end
	lb bc, MEW, 2
	call GivePokemon
	jr nc, .text_script_end
	ld a, $00
	ld [wPlayerMoney], a
	ld [wPlayerMoney + 1], a
	ld [wPlayerMoney + 2], a
.text_script_end
	jp TextScriptEnd

UndergroundPathPalletViridian_RocketGuyText1:
	text_far _UndergroundPathPalletViridian_RocketGuyText1
	text_end

UndergroundPathPalletViridian_RocketGuyText2:
	text_far _UndergroundPathPalletViridian_RocketGuyText2
	text_end
