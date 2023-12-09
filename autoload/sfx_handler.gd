extends Node
class_name SFXHandler

# This is a Singleton/Autoload object that plays sound effects.
#
# The enum SFX lists the sound effects used by SMC. The Dictionary
# sfx has the preloaded sound effect audio files for each of the SFX enums.
#
# To play a sound effect, the caller only needs to call Sfxhandler.playSfx()
# with the appropriate SFX value.
#
# Should we need to play a sound not in our dictionary, then the caller
# can call Sfxhandler.playSound() with the audio file to play.

# Signals

# Preloaded audio files
const audioTELEPORT = preload("res://Audio/SoundEffects/Retro Jump StereoUP Simple 01.mp3")
const audioHEROPWEAPON = preload("res://Audio/SoundEffects/Retro Weapon Arrow 02.mp3")
const audioHEROSWEAPON = preload("res://Audio/SoundEffects/Retro Impact Metal 05.mp3")
const audioHEROEXPLOSION = preload("res://Audio/SoundEffects/Retro Weapon Bomb 06.mp3")
const audioHEROEMPTY = preload("res://Audio/SoundEffects/419023__jacco18__acess-denied-buzz-amplified.mp3")
const audioSHIELD = preload("res://Audio/SoundEffects/44823__timkahn__dronnee.mp3")
const audioHERODEATH = preload("res://Audio/SoundEffects/572335__jarl_fenrir__dies-irae.mp3")
const audioKNIFE = preload("res://Audio/SoundEffects/703708__strangehorizon__throwing_arm_3.mp3")
const audioSKELETONWALKING = preload("res://Audio/SoundEffects/188034__antumdeluge__bones-2.mp3")
const audioSWARRIORDEATH = preload("res://Audio/SoundEffects/704635__zulfish__monster-dying.mp3")
const audioVAMPIREBITE = preload("res://Audio/SoundEffects/268501__bernuy__vampire-bites.mp3")
const audioVAMPIREDEATH = preload("res://Audio/SoundEffects/169058__scorpion67890__slow-zombie-death.mp3")
const audioSGRPWEAPON = preload("res://Audio/SoundEffects/539972__za-games__fire-burst-flash.mp3")
const audioSGRSWEAPON = preload("res://Audio/SoundEffects/706678__sadiquecat__whoosh-bamboo-3.mp3")
const audioSGRDEATH = preload("res://Audio/SoundEffects/660111__matrixxx__purge-remastered.mp3")
const	audioSODPWEAPON = preload("res://Audio/SoundEffects/523205__matrixxx__retro-laser-gun-shot.mp3")
const audioSODSWEAPON = preload("res://Audio/SoundEffects/555519__eminyildirim__mage-fireball-skill.mp3")
const audioSODDEATH1 = preload("res://Audio/SoundEffects/522572__matrixxx__retro-bomb-explosion.mp3")
const audioSODDEATH2 = preload("res://Audio/SoundEffects/414209__jacksonacademyashmore__death.mp3")
const audioSODDEATH3 = preload("res://Audio/SoundEffects/483693__camouflaged_noob__weird_death1.mp3")
const audioSODDEATH4 = preload("res://Audio/SoundEffects/415079__harrietniamh__video-game-death-sound-effect.mp3")
const audioSODDEATH5 = preload("res://Audio/SoundEffects/257796__xtrgamr__flatline.mp3")
const audioOPEN = preload("res://Audio/SoundEffects/270316__littlerobotsoundfactory__open_00.mp3")
const audioCOIN = preload("res://Audio/SoundEffects/444918__matrixxx__ping.mp3")
const audioGEM = preload("res://Audio/SoundEffects/481151__matrixxx__cow-bells-01.mp3")
const audioLIFE = preload("res://Audio/SoundEffects/523651__matrixxx__powerup-05.mp3")
const audioMAXLIFE = preload("res://Audio/SoundEffects/523649__matrixxx__powerup-07.mp3")
const audioPWEAPONREFILL = preload("res://Audio/SoundEffects/396331__nioczkus__1911-reload.mp3")
const audioSWEAPONREFILL = preload("res://Audio/SoundEffects/500294__bratish__shotgun-reload.mp3")
const audioSSHIELDREFILL = preload("res://Audio/SoundEffects/523753__matrixxx__new-skill-01.mp3")
const audioLSHIELDREFILL = preload("res://Audio/SoundEffects/523745__matrixxx__armor-02.mp3")
const audioUIBUTTON = preload("res://Audio/SoundEffects/Retro Event UI 01.mp3")

const NOPITCH = [1.0, 1.0]
const PITCH_2 = [.8, 1.2]

enum SFX {NULL, TELEPORT, HEROPWEAPON, HEROSWEAPON, HEROEXPLOSION, HEROEMPTY, SHIELD, HERODEATH,
					 KNIFE, SKELETONWALKING, SWARRIORDEATH, VAMPIREBITE, VAMPIREDEATH, SGRPWEAPON,
					 SGRSWEAPON, SGRDEATH, SODPWEAPON, SODSWEAPON, SODDEATH1, SODDEATH2, SODDEATH3,
					 SODDEATH4, SODDEATH5, OPEN,  COIN, GEM, LIFE, MAXLIFE, PWEAPONREFILL, SWEAPONREFILL,
					 SSHIELDREFILL, LSHIELDREFILL, UIBUTTON, }

const sfx: Dictionary = {
	# ID									audio file							pitch range	volume		loop?
	SFX.NULL: 						[null, 									[], 				0.0, 			false],
	SFX.TELEPORT:					[audioTELEPORT,					NOPITCH,		-10.0,			false],
	SFX.HEROPWEAPON:  		[audioHEROPWEAPON,			PITCH_2,		-16.0,		false],
	SFX.HEROSWEAPON: 			[audioHEROSWEAPON, 			PITCH_2,		-16.0,		false],
	SFX.HEROEXPLOSION: 		[audioHEROEXPLOSION, 		PITCH_2,		-16.0,		false],
	SFX.HEROEMPTY: 				[audioHEROEMPTY,				NOPITCH,		-35.0,		false],
	SFX.SHIELD: 					[audioSHIELD, 					NOPITCH,		-22.0,			true],
	SFX.HERODEATH: 				[audioHERODEATH,				NOPITCH,		-16.0,		false],
	SFX.KNIFE: 						[audioKNIFE, 						PITCH_2,		-10.0,		false],
	SFX.SKELETONWALKING: 	[audioSKELETONWALKING,	NOPITCH,		-8.0,			true],
	SFX.SWARRIORDEATH:		[audioSWARRIORDEATH,		NOPITCH,		0.0,			false],
	SFX.VAMPIREBITE:			[audioVAMPIREBITE,			NOPITCH,		0.0,			false],
	SFX.VAMPIREDEATH:			[audioVAMPIREDEATH, 		NOPITCH,		-10.0,		false],
	SFX.SGRPWEAPON:				[audioSGRPWEAPON,				PITCH_2,		0,0, 			false],
	SFX.SGRSWEAPON:				[audioSGRSWEAPON,				PITCH_2,		0.0,			false],
	SFX.SGRDEATH:					[audioSGRDEATH,					NOPITCH,		0.0,			false],
	SFX.SODPWEAPON:				[audioSODPWEAPON,				PITCH_2,		0.0,			false],
	SFX.SODSWEAPON:				[audioSODSWEAPON,				PITCH_2,		0.0,			false],
	SFX.SODDEATH1:				[audioSODDEATH1,				NOPITCH,		0.0,			false],
	SFX.SODDEATH2:				[audioSODDEATH2,				NOPITCH,		0.0,			false],
	SFX.SODDEATH3:				[audioSODDEATH3,				NOPITCH,		0.0,			false],
	SFX.SODDEATH4:				[audioSODDEATH4,				NOPITCH,		0.0,			false],
	SFX.SODDEATH5:				[audioSODDEATH5,				NOPITCH,		0.0,			false],
	SFX.OPEN:							[audioOPEN,							PITCH_2,		-8.0,			false],
	SFX.COIN:							[audioCOIN,							NOPITCH,		-8.0,			false],
	SFX.GEM:							[audioGEM,							NOPITCH,		-8.0,			false],
	SFX.LIFE:							[audioLIFE,							NOPITCH,		-8.0,			false],
	SFX.MAXLIFE:					[audioMAXLIFE,					NOPITCH,		-8.0,			false],
	SFX.PWEAPONREFILL:		[audioPWEAPONREFILL,		NOPITCH,		-8.0,			false],
	SFX.SWEAPONREFILL:		[audioSWEAPONREFILL,		NOPITCH,		-8.0,			false],
	SFX.SSHIELDREFILL:		[audioSSHIELDREFILL,		NOPITCH,		-8.0,			false],
	SFX.LSHIELDREFILL:		[audioLSHIELDREFILL,		NOPITCH,		-8.0,			false],
	SFX.UIBUTTON:					[audioUIBUTTON,					NOPITCH,		-8.0,			false],
}
# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# playSfx(sfxKey, parent, pitchRange, volumeDb)
# Play the audio file in our dictionary. We return the
# New audio player so that the caller can manipulate it
# if needs be (like stopping a loop and deleting it).
#
# Parameters
#		sfxKey: SFX					Dictionary key of the audio file to play
#		parent: Node				Add the new AudioStreamPlayer to this parent
#													Default is the tree's current scene
#		pitchRange: Vector2	Randomly alter the pitch between x and y
#													Default is (1,1)
#		volumneDb: float		Set the volume to this value
#													Default is 1.0
# Return
#		Pointer to the audio player
#==
# Just call playSound with the appropriate audio file
func playSfx(sfxKey: SFX) -> AudioStreamPlayer:
	print('Playing ', SFX.keys()[sfxKey])
	return playSound(sfx[sfxKey][0], sfx[sfxKey][1], sfx[sfxKey][2], sfx[sfxKey][3])

# playSound(sound, parent, pitchRange, volumeDb, loopIt)
# Play the audio file
#
# Parameters
#		sound: AudioStream	Audio file to play
#		parent: Node				Add the new AudioStreamPlayer to this parent
#													Default is the tree's current scene
#		pitchRange: Vector2	Randomly alter the pitch between x and y
#													Default is (1,1)
#		volumneDb: float		Set the volume to this value
#													Default is 1.0
#		loopIt: bool				True: Loop the audio, False: Oneshot only
# Return
#		Pointer to the audio player
#==
# Ignore if arguments are null
# Create a new AudioStreamPlayer
# Set the audio file to play
# If it is a oneshot, then delete AudioStreamPlayer when it's finished playing
# (NOTE: The caller must stop the player and delete it when the SFX isn't required anymore)
# Set pitch and volume
# Add new AudioStreamPlayer the indicated node
# Play the sound
func playSound(sound: AudioStream,
	pitchRange: Array = [1.0, 1.0], volumeDb: float = 1.0, loopIt = false) -> AudioStreamPlayer:
	if sound == null: return null

	var streamPlayer = AudioStreamPlayer.new()

	streamPlayer.stream = sound
	if loopIt:
		streamPlayer.connect("finished", streamPlayer.play)
	else:
		streamPlayer.connect("finished", streamPlayer.queue_free)

	streamPlayer.pitch_scale = randf_range(pitchRange[0], pitchRange[1])
	streamPlayer.volume_db = volumeDb

	Globals.sfxNode.add_child(streamPlayer)
	streamPlayer.play()
	return streamPlayer

# remove(audioPlayer)
# Stop the audio player and remove it from the tree
#
# Parameters
#		audioPlayer: AudioStreamPlayer	Pleyer to remove
# Return
#		None
#==
# Stop the player
# Free it
func remove(player: AudioStreamPlayer) -> void:
	if player == null: return
	player.stop()
	player.queue_free()

# killAll()
# Get rid of all sound effects
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func killAll() -> void:
	for n in Globals.sfxNode.find_children("*", "AudioStreamPlayer", false, false):
		if n != null:
			n.stop()
			n.queue_free()
