extends Node
class_name SFXHandler

# This is a Singleton/Autoload object that plays sound effects.
#
# The enum SFX lists the sound effects used by SMC. The Dictionary
# sfx has the preloaded sound effect audio files for each of the SFX enums.
#
# To play a sound effect, the caller only needs to call Sfxhandler.play_sfx()
# with the appropriate SFX value.
#
# Should we need to play a sound not in our dictionary, then the caller
# can call Sfxhandler.play_sound() with the audio file to play.

# Preloaded audio files

enum SFX {HEROPWEAPON, HEROSWEAPON, HEROEXPLOSION, HEROEMPTY, KNIFE, }
const sfx: Dictionary = {
SFX.HEROPWEAPON:  preload("res://Audio/SoundEffects/Retro Weapon Arrow 02.mp3"),
SFX.HEROSWEAPON: preload("res://Audio/SoundEffects/Retro Impact Metal 05.mp3"),
SFX.HEROEXPLOSION: preload("res://Audio/SoundEffects/Retro Weapon Bomb 06.mp3"),
SFX.HEROEMPTY: preload("res://Audio/SoundEffects/419023__jacco18__acess-denied-buzz-amplified.mp3"),
SFX.KNIFE: preload("res://Audio/SoundEffects/703708__strangehorizon__throwing_arm_3.mp3"),
}
# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# play_sfx(sfxKey, parent, pitchRange, volumeDb)
# Play the audio file in our dictionary
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
#		None
#==
# Just call play_sound with the appropriate audio file
func play_sfx(sfxKey: SFX, parent: Node = get_tree().current_scene,
	pitchRange: Vector2 = Vector2(1.0,1.0), volumeDb: float = 1.0) -> void:
	play_sound(sfx[sfxKey], parent, pitchRange, volumeDb)

# play_sound(sound, parent, pitchRange, volumeDb)
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
# Return
#		None
#==
# Ignore if arguments are null
# Create a new AudioStreamPlayer
# Set the audio file to play
# Delete AudioStreamPlayer when it's finished playing
# Set pitch and volume
# Add new AudioStreamPlayer the indicated node
# Play the sound
func play_sound(sound: AudioStream, parent: Node = get_tree().current_scene,
	pitchRange: Vector2 = Vector2(1.0,1.0), volumeDb: float = 1.0) -> void:
	if sound != null and parent != null:
		var streamPlayer = AudioStreamPlayer.new()

		streamPlayer.stream = sound
		streamPlayer.connect("finished", streamPlayer.queue_free)
		streamPlayer.pitch_scale = randf_range(pitchRange.x, pitchRange.y)
		streamPlayer.volume_db = volumeDb

		parent.add_child(streamPlayer)
		streamPlayer.play()
