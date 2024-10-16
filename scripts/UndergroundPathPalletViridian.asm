UndergroundPathPalletViridian_Script:
	call EnableAutoTextBoxDrawing
	ld hl, UndergroundPathPalletViridian_ScriptPointers
	ld a, [wUndergroundPathPalletViridianCurScript]
	jp CallFunctionInTable

UndergroundPathPalletViridian_ScriptPointers:
	def_script_pointers
	dw_const UndergroundPathPalletViridianDefaultScript,                SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_DEFAULT
	dw_const UndergroundPathPalletViridianRocketGuyWalksToPlayerScript, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_TO_PLAYER
	dw_const UndergroundPathPalletViridianRocketGuyTalkToPlayerScript,  SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_TALK_TO_PLAYER
	dw_const UndergroundPathPalletViridianDisableScript,                SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_NOOP

UndergroundPathPalletViridianDisableScript:
	ret

UndergroundPathPalletViridianDefaultScript:
	ld a, [wPartyCount]
	cp $00
	ret nz
	ld hl, UndergroundPathPalletViridian_RocketGuy_sees_Player_Coords
	call ArePlayerCoordsInArray
	ret nc
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_MeetEvilTrainer)
	ld c, a
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	xor a
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_NOPKMN
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_TO_PLAYER
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

UndergroundPathPalletViridian_RocketGuy_sees_Player_Coords:
	dbmapcoord 2, 10
	dbmapcoord 3, 10
	dbmapcoord 4, 10
	dbmapcoord 5, 10
	dbmapcoord 5, 11
	dbmapcoord 5, 12
	dbmapcoord 5, 13
	db -1 ; end

UndergroundPathPalletViridianRocketGuyWalksToPlayerScript:
	ld a, SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a

	ld a, $1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, $1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ldh a, [hNPCPlayerYDistance]
	dec a
	ldh [hNPCPlayerYDistance], a
	predef FindPathToPlayer
	ld de, wNPCMovementDirections2
	ld a, UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hSpriteIndex], a
	call MoveSprite

	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_TALK_TO_PLAYER
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

UndergroundPathPalletViridianRocketGuyTalkToPlayerScript:
	; waiting for rocket guy is ready to walk to player
	ld a, [wd730]
	bit 0, a
	ret nz

	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; reset to map music
	ld a, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID

	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_NOOP
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

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
