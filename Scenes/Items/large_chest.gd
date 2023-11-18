extends RigidBody2D

var chestClosed: bool = true

func _ready():
	Globals.scaleMe(self, 1.2)


func _on_input_event(_viewport, event, _shape_idx):
	print('LargeChest Clicked')
	if event is InputEventMouseButton and chestClosed:
		$AnimatedSprite2D.play("Open")
		chestClosed = false
