extends Area2D
class_name Item

#++
# This defines the parent class for an Item.
#
#--

#+
# Properties
#-
enum itemIs {COIN, GEM, MAXLIFE, LIFE, PWEAPON, SWEAPON, SSHIELD, LSHIELD, }
@onready var timer#: Timer = Timer.new()

# Designer will choose one of these types in the Inspector
@export var expiresIn: float = 5.0

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var increaseItemCountBy: int
@export var itemType: itemIs

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

# _ready()
# Called when the object is ready
#
# Paramters
#	None
# Return
#	None
#==
# Scale our image
# Create a timer to kill us after a certain time
func _ready() -> void:
	Globals.scaleMe(self.find_child('ItemImage'), scaleFactor)
	timer  = Timer.new()
	add_child(timer)
	timer.wait_time = expiresIn
	timer.one_shot = true
	timer.connect("timeout", _on_expires, 0)


#+
# Class specific methods
#-

# startExpires()
# Start our expiration timer
#
# Parameters
#		None
# Return
#		None
#==
# Start our timer
func startExpires() -> void:
	timer.start()

# weHaveBeenCollected()
# Called by the child when a collision with the Hero is detected.
#
# Increments the appropriate counter
#
# Paramters
#	None
# Return
#	None
#==
# Bump the appropriate counter based on our type
# Then we go away
func collected() -> void:
	match itemType:
		itemIs.COIN:
			Globals.coinCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.COIN)
		itemIs.GEM:
			Globals.gemCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.GEM)
		itemIs.MAXLIFE:
			Globals.maxHealth += increaseItemCountBy
			Globals.health += 15
			SfxHandler.playSfx(SfxHandler.SFX.MAXLIFE)
		itemIs.LIFE:
			Globals.health += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.LIFE)
		itemIs.PWEAPON:
			Globals.primaryWeaponCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.PWEAPONREFILL)
		itemIs.SWEAPON:
			Globals.secondaryWeaponCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.SWEAPONREFILL)
		itemIs.SSHIELD:
			Globals.shortShieldCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.SSHIELDREFILL)
		itemIs.LSHIELD:
			Globals.longShieldCount += increaseItemCountBy
			SfxHandler.playSfx(SfxHandler.SFX.LSHIELDREFILL)

	queue_free()

# Signal callbacks

# Just delete us when timer goes off
func _on_expires() -> void:
	queue_free()
