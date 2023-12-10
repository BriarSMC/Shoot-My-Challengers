extends Node
class_name MUSICHandler

# This is a Singleton/Autoload object that plays music files.
#
# The enum MUSIC lists the musicused by SMC. The Dictionary
# music has the preloaded music  audio files for each of the MUSIC enums.
#
# Music is meant to be played in the background. SMC will have only one music file
# at a time playing in the background. Levels will tell us which file to play.
#
# However, some events require the level's background music to be paused and a new
# file to start playing in its place until the replacement music is no longer needed.
# To do this we have two (2) AudioStreamPlayer nodes. The Primary player and Interruption player.
#
# NOTE: We loop all the players

# Signals

# Properties

# Preloaded audio files

const musicUIBG = preload("res://Audio/Music/Eyes_of_Glory.mp3")
const musicLEVELS = preload("res://Audio/Music/Heads Up - The 126ers.mp3")
const musicSOD1 = preload("res://Audio/Music/507307__matrixxx__the-battle-between-scorpio-and-orion.mp3")
const musicSOD2 = preload("res://Audio/Music/510953__theojt__cinematic-battle-song.mp3")
const musicSOD3 = preload("res://Audio/Music/676998__snowfightstudios__fight-music-synth-tense-loop.mp3")
const musicSOD4 = preload("res://Audio/Music/352171__sirkoto51__boss-battle-loop-1.mp3")
const musicSOD5 = preload("res://Audio/Music/591500__klavo1985__saying-good-bye-before-battle-music-for-war-game-in-vr.mp3")
const musicVAMPIRE = preload("res://Audio/Music/Retro Instrument - choir bass - C11.mp3")
const musicGRIM = preload("res://Audio/Music/516439__wolfdoctor__ominous-whistling.mp3")

enum MUSIC {NULL, UIBG, LEVELS,SOD1, SOD2, SOD3, SOD4, SOD5, VAMPIRE, GRIM, }

const music: Dictionary = {
# ID							audio file			volume_db
	MUSIC.NULL: 		[null,					-5.0],
	MUSIC.UIBG: 		[musicUIBG,			-5.0],
	MUSIC.LEVELS:		[musicLEVELS,		-12.0],
	MUSIC.SOD1:			[musicSOD1,			-5.0],
	MUSIC.SOD2:			[musicSOD2,			-5.0],
	MUSIC.SOD3:			[musicSOD3,			-5.0],
	MUSIC.SOD4:			[musicSOD4,			-5.0],
	MUSIC.SOD5:			[musicSOD5,			-5.0],
	MUSIC.VAMPIRE:	[musicVAMPIRE,	-5.0],
	MUSIC.GRIM:			[musicGRIM,			-5.0],
}

const AUDIOSTREAM: int = 0
const VOLUMEDB: int = 1

#var primaryPlayer: AudioStreamPlayer
#var interruptPlayer: AudioStreamPlayer
var primaryPlaybackPos: float

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func _ready() -> void:
	#primaryPlayer = AudioStreamPlayer.new()
	#interruptPlayer = AudioStreamPlayer.new()

	$PrimaryPlayer.autoplay = false
	$InterruptPlayer.autoplay = false

# Class specific methods

# playPrimary(id)
# Start playing music file in the primary player.
# Any existing music will be stopped and replaced with the
# new music.
#
# Parameters
#		id: MUSIC						ID of the music to start playing
# Return
#		None
#==
# Stop whatever is currently playing
# Set the volume for the new audio
func playPrimary(id: MUSIC) -> void:
	$InterruptPlayer.stop()
	$PrimaryPlayer.stop()
	$PrimaryPlayer.set_stream(music[id][AUDIOSTREAM])
	$PrimaryPlayer.volume_db = music[id][VOLUMEDB]
	$PrimaryPlayer.play()

# resumePrimary()
# Stop the interrupt player and resume playing primary
#
# Parameters
#		None
# Return
#		None
#==
# Stop the interrup player
# Unpause the primary player
func resumePrimary() -> void:
	$InterruptPlayer.stop()
	$PrimaryPlayer.play(primaryPlaybackPos)

# playInterrup(id)
# Stop the primary player and begin the indicated audio file
#
# Parameters
#		id: MUSIC						ID of music to play
# Return
#		None
#==
# What the code is doing (steps)
func playInterrupt(id: MUSIC) -> void:
	$PrimaryPlayer.stop()
	primaryPlaybackPos = $PrimaryPlayer.get_playback_position()
	$InterruptPlayer.set_stream(music[id][AUDIOSTREAM])
	$InterruptPlayer.volume_db = music[id][VOLUMEDB]
	$InterruptPlayer.play()

# Signal Callbacks


# Just loop the audio
func _on_primary_player_finished():
	$PrimaryPlayer.play(0.0)

# Just loop the audio
func _on_interrupt_player_finished():
	$InterruptPlayer.play(0.0)
