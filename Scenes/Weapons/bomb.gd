extends Weapon
class_name Bomb
#++
# This class is for the Hero's secondary weapon: A bomb
#
# The Hero will drop this bomb and it will stay at that location until
# it detonates. It has a blast radius. All Challengers in that radius 
# receive damage. Through magic shielding, the bomb does not damage
# the Hero.
#
# Since we won't be dropping a bizillion bombs at once, we will not use
# pooling for this weapon. Therefore, the DetentationTimer can autostart.
# It also is a one-shot because, well, it blows itself up!
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var damageRadius: float

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

	
#+
# Class specific methods
#-
