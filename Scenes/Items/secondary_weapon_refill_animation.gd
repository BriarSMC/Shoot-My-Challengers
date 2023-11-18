extends AnimationPlayer

var incr: float = 3.0
var dir: float = 1.0
var pos: float = 0.0

const upperLimit: float = 20.0
const lowerLimit: float = -20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"..".position.y = pos + (incr * dir * delta)
	if (pos <= lowerLimit):
		dir = 1.0
	if (pos >= upperLimit):
		dir = -1.0
