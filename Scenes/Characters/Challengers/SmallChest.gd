extends RigidBody2D

var chestClosed: bool = true

func _ready():
	Globals.scaleMe(self)


func _on_input_event(_viewport, event, _shape_idx):
	print('SmallChest Clicked')
	if event is InputEventMouseButton and chestClosed:
		$AnimatedSprite2D.play("Open")
		chestClosed = false

