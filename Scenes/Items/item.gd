extends Area2D
class_name Item

#++
# This defines the parent class for an Item.
#
#--

#+
# Properties
#-
var isPowerup: bool = false

# Designer will choose one of these types in the Inspector
enum itemIs {COIN, GEM, MAXLIFE, LIFE, PWEAPON, SWEAPON, SSHIELD, LSHIELD, }

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
func _ready() -> void:
	if not isPowerup: Globals.scaleMe(self, scaleFactor)

#+
# Class specific methods
#-

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
		itemIs.GEM:
			Globals.gemCount += increaseItemCountBy
		itemIs.MAXLIFE:
			Globals.maxHealth += increaseItemCountBy
		itemIs.LIFE:
			Globals.health += increaseItemCountBy
		itemIs.PWEAPON:
			Globals.primaryWeaponCount += increaseItemCountBy
		itemIs.SWEAPON:
			Globals.secondaryWeaponCount += increaseItemCountBy
		itemIs.SSHIELD:
			Globals.shortShieldCount += increaseItemCountBy
		itemIs.LSHIELD:
			Globals.longShieldCount += increaseItemCountBy

	queue_free()
