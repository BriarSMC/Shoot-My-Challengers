extends Area2D

var FB_EX: int = 1
const offset: float = 12.0

func _ready():
	Globals.scaleMe(self, .1)


func _on_explode_timer_timeout():
	if FB_EX == 1:
		position.x += offset
		$AnimatedSprite2D.play("Explosion")
		FB_EX = 2
	else:
		position.x -= offset
		$AnimatedSprite2D.play("Throw")
		FB_EX = 1
