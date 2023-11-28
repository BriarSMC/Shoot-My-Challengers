extends Character
class_name SkeletonGrimReaper
# This character 'stalks' the Hero. When the Hero is in out Notice Area, then
# we use a Naviation Agent to move toward him. The NavigationRegion2D in the
# current level defines our area of operation.
#
# We also play special music when the Hero is in our Notice Area.

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Executed when the node is ready
#
# Paramters
#	None
# Return 
#	None
#==
# Calculate the first target position for the path
func _ready() -> void:
	$NavigationAgent2D.target_position = Globals.heroPosition

# _physics_process(delta)
# Called every physics cycle
#
# Paramters
#	delta: float				Amount of time elaped since last call
# Return 
#	None
#==
# Only run the path and move code if the Hero is in our notice area
#	Calculate the new path and move us along the path
#	# If we upgrade the graphics, then we should look at the dude
func _physics_process(_delta) -> void:
	return # TAKE THIS OUT WHEN YOU WANT TO DO REAL STUFF
	# May have to do a called deferred if the first from being null is a problem
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		#look_at(Globals.heroPosition)

# _on_recalculate_path_timer_timeout()
# Recalculate the path
#
# We want to run this every so often since the calculations are CPU intensive.
# So this method is attached to $Timers/RecalculatePathTimer to accomplish that.
#
# Paramters
#	None
# Return 
#	None
#==
# What the code is doing (steps)
func _on_recalculate_path_timer_timeout() -> void:
	$NavigationAgent2D.target_position = Globals.heroPosition
	
# _on_notice_area_body_entered(body)
# Set the active flag only if the Hero enters the notice area.
#
# Paramters
#	body: Object				# Reference to the node entering the area
# Return 
#	None
#==
# If it's the Hero, then set the active flag
# TODO: Play Music
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"):
		active = true
		
# _on_notice_area_body_exited(body)
# Clear the active flag only if the Hero leaves the notice area.
#
# Paramters
#	body: Object				# Reference to the node exiting the area
# Return 
#	None
#==
# If it's the Hero, then clear the active flag
# TODO: Turn off music
func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"):
		active = false

	
# Class specific methods

# Signal callbacks
