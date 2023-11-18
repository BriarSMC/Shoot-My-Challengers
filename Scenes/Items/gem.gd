extends StaticBody2D

#++
# Remember to set the gem images in the editor
#--
@export var images: Array[Texture] 
@onready var imagesSize: int = images.size()

func _ready():
	Globals.scaleMe(self, .7)
	setGemImage()
	
#++
# We randomize what image to show
#--
func setGemImage() -> void:
	$Sprite2D.texture = images[randi_range(0, imagesSize - 1)]
