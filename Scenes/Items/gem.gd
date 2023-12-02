extends Item
class_name Gem

#++
# <description>
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var images: Array[Texture]

# The following are set based on the Inspector values
@onready var imagesSize: int = images.size()

#+
# Virtual Godot methods
#-

# _ready()
# Called when the object is ready
#
# Parameters
#	None
# Return
#	None
#==
# Set our gem image randomly
# Call the parent method
func _ready():
	setGemImage()
	super._ready()


#+
# Class specific methods
#-

# setGemImage()
# Set the gem to a random gem image
#
# Parameters
#	None
# Return
#	None
#==
# Randomly set the image to one in our images array
func setGemImage() -> void:
	$ItemImage.texture = images[randi_range(0, imagesSize - 1)]

# See if Hero collected us
func _on_body_entered(body):
	if body.is_in_group("Hero"):
		collected()
