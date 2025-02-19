UndergroundPathPalletViridian_Script:
	call EnableAutoTextBoxDrawing
	ld hl, UndergroundPathPalletViridian_ScriptPointers
	ld a, [wUndergroundPathPalletViridianCurScript]
	jp CallFunctionInTable

UndergroundPathPalletViridian_ScriptPointers:
	def_script_pointers
	dw_const UndergroundPathPalletViridianDefaultScript,                SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_DEFAULT
	dw_const UndergroundPathPalletViridianPlayerGiveRocketGuyAttention, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_PLAYER_GIVE_ROCKETGUY_ATTENTION
	dw_const UndergroundPathPalletViridianRocketGuyWalksToPlayerScript, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_TO_PLAYER
	dw_const UndergroundPathPalletViridianRocketGuyTalkToPlayerScript,  SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_TALK_TO_PLAYER
	dw_const UndergroundPathPalletViridianRocketGuyWalksBackScript,     SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_BACK
	dw_const UndergroundPathPalletViridianRocketGuyWalksLeftScript,     SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_LEFT
	dw_const UndergroundPathPalletViridianResetScript,                  SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_RESET,
	dw_const UndergroundPathPalletViridianDisableScript,                SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_NOOP

UndergroundPathPalletViridianDisableScript:
	ret

UndergroundPathPalletViridianDefaultScript:
	ld a, [wPartyCount]
	cp $00
	ret nz
	ld hl, .RocketGuy_sees_Player_Coords
	call ArePlayerCoordsInArray
	ret nc
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	ret nz
ENDC
	ld a, SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_MeetEvilTrainer)
	ld c, a
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
.DetectPlayerDirection
	ld a, [wPlayerDirection]
	cp PLAYER_DIR_DOWN
	jr z, .PlayerLookDown
.PlayerLookUp
	ld a, SPRITE_FACING_DOWN
	jr .ShowHinterOverPlayer
.PlayerLookDown
	ld a, SPRITE_FACING_UP
.ShowHinterOverPlayer
	ldh [hSpriteFacingDirection], a
	ld a, UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_PLAYER_GIVE_ROCKETGUY_ATTENTION
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

.RocketGuy_sees_Player_Coords:
	dbmapcoord 6, 16
	dbmapcoord 7, 16
	dbmapcoord 8, 16
	dbmapcoord 9, 16
	dbmapcoord 6, 22
	dbmapcoord 7, 22
	dbmapcoord 8, 22
	dbmapcoord 9, 22
	db -1 ; end
	
UndergroundPathPalletViridianPlayerGiveRocketGuyAttention:
	; waiting for rocket guy is ready to look to player
	WaitForSpritsMoveFinish

	xor a
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_NOPKMN
	ldh [hTextID], a
	call DisplayTextID
	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_TO_PLAYER
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

UndergroundPathPalletViridianRocketGuyWalksToPlayerScript:
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
	WaitForSpritsMoveFinish

	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; reset to map music
	ld a, TEXT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hTextID], a
	call DisplayTextID

	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_BACK
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

UndergroundPathPalletViridianRocketGuyWalksBackScript:
	ld a, [wPlayerDirection]
	cp PLAYER_DIR_DOWN
	jr z, .PlayerLookDown
.PlayerLookUp
	ld a, [wUndergroundPathPalletViridianPlayerBuyedMew]
	and a
	jr nz, .noSelected1
.yesSelected1
	ld de, .RocketGuyWalkUp4
	jr .move
.noSelected1
	ld de, .RocketGuyWalkDown2
	jr .move
.PlayerLookDown
	ld a, [wUndergroundPathPalletViridianPlayerBuyedMew]
	and a
	jr nz, .noSelected2
.yesSelected2
	ld de, .RocketGuyWalkDown4
	jr .move
.noSelected2
	ld de, .RocketGuyWalkUp2

.move
	ld a, UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hSpriteIndex], a
	call MoveSprite

	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY_WALKS_LEFT
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

.RocketGuyWalkDown4
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
.RocketGuyWalkDown2
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1

.RocketGuyWalkUp4
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
.RocketGuyWalkUp2
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1

UndergroundPathPalletViridianRocketGuyWalksLeftScript:
	WaitForSpritsMoveFinish
	ld a, [wXCoord]
	sub $6
	jr z, .RocketGuyLookLeft
.walk1
	ld de, .RocketGuyWalkLeft1
	sub $1
	jr z, .move
.walk2
	ld de, .RocketGuyWalkLeft2
	sub $1
	jr z, .move
.walk3
	ld de, .RocketGuyWalkLeft3
						
.move
	ld a, UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ldh [hSpriteIndex], a
	call MoveSprite
.RocketGuyLookLeft

	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_RESET
	ld [wUndergroundPathPalletViridianCurScript], a
	ret

.RocketGuyWalkLeft3
	db NPC_MOVEMENT_LEFT
.RocketGuyWalkLeft2
	db NPC_MOVEMENT_LEFT
.RocketGuyWalkLeft1
	db NPC_MOVEMENT_LEFT
	db -1
						
UndergroundPathPalletViridianResetScript:
	WaitForSpritsMoveFinish
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; reset to map music
	ld a, [wUndergroundPathPalletViridianPlayerBuyedMew]
	and a
	jr nz, .noSelected
.yesSelected
	ld a, HS_UNDERGROUNDPATHPALLETVIRIDIAN_ROCKETGUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_NOOP
	ld [wUndergroundPathPalletViridianCurScript], a
	ret
.noSelected
	ld a, SCRIPT_UNDERGROUNDPATHPALLETVIRIDIAN_DEFAULT
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
	ld [wUndergroundPathPalletViridianPlayerBuyedMew], a
	and a
	jr nz, .goway
	lb bc, MEW, 2
	call GivePokemon
	jr nc, .text_script_end
	ld a, $00
	ld [wPlayerMoney], a
	ld [wPlayerMoney + 1], a
	ld [wPlayerMoney + 2], a
	jr .text_script_end
.goway
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_MeetEvilTrainer)
	ld c, a
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld hl, UndergroundPathPalletViridian_RocketGuyText3
	call PrintText
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
.DetectPlayerDirection
	ld a, [wPlayerDirection]
	cp PLAYER_DIR_DOWN
	jr z, .PlayerLookDown
.PlayerLookUp
	ld a, D_DOWN
	jp .StartWalk
.PlayerLookDown
	ld a, D_UP
.StartWalk
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	call UpdateSprites
.text_script_end
	jp TextScriptEnd

UndergroundPathPalletViridian_RocketGuyText1:
	text_far _UndergroundPathPalletViridian_RocketGuyText1
	text_end

UndergroundPathPalletViridian_RocketGuyText2:
	text_far _UndergroundPathPalletViridian_RocketGuyText2
	text_end

UndergroundPathPalletViridian_RocketGuyText3:
	text_far _UndergroundPathPalletViridian_RocketGuyText3
	text_end
	