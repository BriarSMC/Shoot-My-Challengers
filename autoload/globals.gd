extends Node

# Signals
signal updateUIValues

# To randomize or not to randomize
@export var trueRandom: bool = false

# Misc globals
var currentLevelNdx: int				# Current level playing
var currentLevel: Object				# Current level object pointer
var weaponsDeployed: Node2D			# Pointer to the WeaponsDeployed node in the current level
var startSpawning: bool = false	# Don't want to start spawning until the hero has moved

# Mcp sets this
enum inputType {KEYBOARD, GAMECONTROLLER, }
var inputDevice: inputType

# This block is so that enemies can find the Hero.
# The hero must constantly update his position here
# so other characters can find him.
var heroPosition: Vector2

# This block has the variables that keep track of inventory, counts, life,
# etc. These all have setters that update the game play UI with current values.
var health: int :
	set(val):
		health = val
		updateUIValues.emit()

var maxHealth: int :
	set(val):
		if val < 0:
			maxHealth = 0
		else:
			maxHealth = val
		updateUIValues.emit()

var primaryWeaponCount: int :
	set(val):
		if val < 0:
			primaryWeaponCount = 0
		else:
			primaryWeaponCount = val
		updateUIValues.emit()

var secondaryWeaponCount: int :
	set(val):
		if val < 0:
			secondaryWeaponCount = 0
		else:
			secondaryWeaponCount = val
		updateUIValues.emit()

var shortShieldCount: int :
	set(val):
		if val < 0:
			shortShieldCount = 0
		else:
			shortShieldCount = val
		updateUIValues.emit()

var longShieldCount: int :
	set(val):
		if val < 0:
			longShieldCount = 0
		else:
			longShieldCount = val
		updateUIValues.emit()

var coinCount: int :
	set(val):
		if val < 0:
			coinCount = 0
		else:
			coinCount = val
		updateUIValues.emit()

var gemCount: int :
	set(val):
		if val < 0:
			gemCount = 0
		else:
			gemCount = val
		updateUIValues.emit()

# May be able to delete this one and use the challengersLeft in each Level
var challengersDefeated: int :
	set(val):
		challengersDefeated = val
		updateUIValues.emit()


# This block allows all the tiny spite and sprite sheet images to scale up
# to a consistent size by calling scaleMe().
@export var scaleByBase: float = 3.0
var scaleBy: Vector2 = Vector2(scaleByBase, scaleByBase)

# scaleMe(me, additionalScale)
# Scale the the object me
#
# Due to very bad choices, we chose graphics from multiple sources.
# These graphics are not on the same scale. So we've structured all the parent
# classes to call this method to scale the object so that it looks 'right'
# in the Viewport.
#
# Parameters
#	me: Object					Object to scale
#	additionalScale: float		Scale by this additional amount
# Return
#	None
#==
# Set the scale of the object in me by a base scale (scaleByBase) multiplied
# by the additionalScale amount (if present; default is 1.0)
func scaleMe(me: Object, additionalScale: float = 1.0) -> void:
	me.scale = scaleBy * additionalScale

# positionUIImage(me)
# Called by UI screens to center their images in the viewport
#
# Paramters
#	me: Object					Object to position
# Return
#	None
#==
# Set the new position by centering the object me in the
# Viewport.
func positionUIImage(me):
	var dims: Vector2 = get_viewport().size
	me.position.x = dims.x/2.0
	me.position.y = dims.y/2.0

