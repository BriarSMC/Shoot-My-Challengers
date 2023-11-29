extends CanvasLayer
class_name GamePlayUI

# This defines the class for the UI used during game play
#
# Get all the values from the labels. We will use those to build
# the text values as we update the game play UI.
#
# We listen for the Globals autoload script to emit signal to
# update the game play UI and then update the UI with the values
# from Globals.

# Properties
const fullColor: Color = Color(1,1,1,1)
const emptyColor: Color = Color(1,0,0,1)

# GamePlayUI label values
enum uiLabelType {ARROWS, BOMBS, SSHIELDS, LSHIELDS, COINS, GEMS, CHALLENGERSLEFT, }
var uiLabels: Dictionary = {}

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
# Connect to the Globals signal to update the game play UI
# Save the labels set in the Inspector
func _ready() -> void:
	Globals.connect("updateUIValues", updateUI)
	saveUILabels()

# Class specific methods

# saveUILabels)
# Save all the GamePlayUI labels to refresh their values later
#
# Parameters
#		None
# Return
#		None
#==
# Copy what is in the labels at level start to Dictionary
func saveUILabels() -> void:
	uiLabels[uiLabelType.ARROWS] = $Panel/Inventory/Arrows.text
	uiLabels[uiLabelType.BOMBS] = $Panel/Inventory/Bombs.text
	uiLabels[uiLabelType.SSHIELDS] = $Panel/Inventory/ShortShields.text
	uiLabels[uiLabelType.LSHIELDS] = $Panel/Inventory/LongShields.text
	uiLabels[uiLabelType.COINS] = $Panel/ItemCounts/Coins.text
	uiLabels[uiLabelType.GEMS] = $Panel/ItemCounts/Gems.text
	uiLabels[uiLabelType.CHALLENGERSLEFT] = $Panel/ItemCounts/ChallengersLeft.text

# updateUI()
# Updates all the values on the GamePlayUI
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func updateUI() -> void:
	$Panel/Inventory/Arrows.text = uiLabels[uiLabelType.ARROWS] + str(Globals.primaryWeaponCount)
	setColor(Globals.primaryWeaponCount, $Panel/Inventory/Arrows)
	$Panel/Inventory/Bombs.text = uiLabels[uiLabelType.BOMBS] + str(Globals.secondaryWeaponCount)
	setColor(Globals.secondaryWeaponCount, $Panel/Inventory/Bombs)
	$Panel/Inventory/ShortShields.text = uiLabels[uiLabelType.SSHIELDS] + str(Globals.shortShieldCount)
	setColor(Globals.shortShieldCount, $Panel/Inventory/ShortShields)
	$Panel/Inventory/LongShields.text = uiLabels[uiLabelType.LSHIELDS] + str(Globals.longShieldCount)
	setColor(Globals.longShieldCount, $Panel/Inventory/LongShields)
	$Panel/ItemCounts/Coins.text = uiLabels[uiLabelType.COINS] + str(Globals.coinCount)
	$Panel/ItemCounts/Gems.text = uiLabels[uiLabelType.GEMS] + str(Globals.gemCount)
	$Panel/ItemCounts/ChallengersLeft.text = uiLabels[uiLabelType.CHALLENGERSLEFT] + str(get_parent().challengersLeft)
	$Panel/HealthBar.max_value = Globals.maxHealth
	$Panel/HealthBar.value = Globals.health

func setColor(v: int, e: Label) -> void:
	if v > 0:
		e.modulate = fullColor
	else:
		e.modulate = emptyColor


# Signal Callbacks
