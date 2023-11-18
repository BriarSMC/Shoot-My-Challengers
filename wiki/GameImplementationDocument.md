This documents how the Godot application is constructed.

At the moment, it is an unorganized collection of important information.

# Collision Layers

SMC operates with eight (8) collision layers:

1. Hero - This is assigned to the Hero scene
1. Challenger - This is assigned to Vampire, Skeleton Warrior, Skeleton Grim Reaper, and Skull of Death scenes.
1. Hero Weapons - This is assigned to both of the Hero's weapons.
1. Challenger Weapons - This is assign to all of the Challenger character-type weapons
1. Containers and Items - This is assigned to all of the containers and items within them.
1. Power-ups - This is assigned to all of the power-ups.
1. Zones and Areas - Unassigned at this time as we are not using these right now.
1. Walls and Objects - This is assigned to all walls and objects that other scenes need to 'see'. Used mainly by the tile sets.

# Groups

We use groups to add metadata about certain scenes. We use this to make decisions on whether or not to execute certain code. Example: Run code for a signal only if it's the Hero:

```if body.is_in_group("Hero"):```

Current groups are:
* Hero
* Challenger
* HeroWeapon
* ChallengerWeapon

# Directory Structure 
* res://
  - Audio
    + Music
    + SoundEffects
  - autoload
  - documentation
    + images
  - Graphics
    + Challengers
      * SkeletonGrimReaper
      * SkeletonWarrior
      * SkullOfDeath
    + Hero
    + Items
      * Gems
    + Misc
    + Powerups
    + UIImages
    + Weapons
      * Explosion1
      * Fireball1
      * FireBlast
  - Scenes
    + Characters
      * Challengers
    + Items
    + Levels
    + Sandbox
    + UI
    + Weapons
  - templates
  - wiki

# SMC Specific Classes

For nodes/objects that have common properties and methods we define a single parent class. We then define 
child classes as we need them. At this time we have only a single inheritance from the parent class. 
The child classes have no children.

## Current Classes

* Character
  * Hero
  * SkeletonWarrior
  * SkeletonGrimReaper
  * Vampire
  * SkullOfDeath
* Weapon
  * Bomb
  * Bolt
  * Knife
  * FireBall
  * Scythe
  * Laser
  * FireBlast
  * ShortShield
  * LongShield
* Chest
  * SmallChest
  * MediumChest
  * LargeChest
* Item
  * Coin
  * Gem
  * ExtraLifePoints
* PowerUp
  * PrimaryWeaponRefill
  * SecondaryWeaponRefill
  * ShortShieldRefill
  * LongShieldRefill
  * LifePotion
    
# Level/UI Screen Transitions

## Animations

Each Level and UI Screen has an AnimationPlayer attached to it. The AnimationPlayer has two animations:
* FadeFromBlack
* FadeToBlack

FadeFromBlack plays automatically when the scene is loaded. The scene calls AnimationPlayer.play("FadeToBlack") 
when it's time to display another scene. Also, a method track is added to this animation. It's purpose is to call the
scene's `goToNextScreen()` method at the end of the animation. This triggers the change to the next scene.

## MCP 

SMC autoloads the MCP (Master Control Program) from file: 
> `res://master_control_program.gd`

MCP defines the function 
  > `MCP.changeGameState(newState: state, level: int = 0)`

All the Levels and UI Screens call this function when a new Level or Screen should be loaded. For levels this would be
when the player wins or loses the level. For UI Screens, this would be when the player clicks on a control on the UI Screen
that requires a new scene to be loaded.

*__state__* indicates the next screen to load. Valid values are:
* MCP.state.START - Start a new game
* MCP.state.WIN - Level finished with a win
* MSP.state.LOSE - Level finished with a lose
* MSP.state.CREDITS - Display the game credits
* MSP.state.LEVEL - Display  `res://Scenes/Levels/Level_n.tscn` where n is the level's number
* 
Each Level or UI Screen scene must define the function 
  ```
    func goToNextScreen() -> void
    MCP.changeGameState(MCP.state.X)
  ```

Where `X` is the appropriate MCP.state value from above.

Because we use FadeToBlack/FadeFromBlack animations on each scene to provide
smooth transitions the scene's script does not call this function directly. Instead
the FadeToBlack animation has a Method track that calls `goToNextScreen` at the end
of the animation.

## UI

SMC has two (2) UI components: Game Control and Play Information.

The player interacts with the Game Control UI to:
* Start the game
* Quit the game
* See the credits
* Continue the game from a win or loss during play

### Game Control UI

This is consists of buttons allowing the player to choose whether they want to play, quit, continue or see the credits.
Each scene using a Game Control UI button defines a corresponding signal. When the button is clicked, then the function
for that button emits the associated signal. The parent node connects to the signal and responds to it.

#### Fading the UI

This takes some doing. We need to send a signal down to the UI to run an animation to fade itself. So we have defined a
signal in the MCP: `signal fadeTheUI`

Each screen needs to emit this signal (`MCP.fadeTheUI.emit()`) whenever it fades itself. The UI component of the screen
needs to connect to that signal and then provide a routine to respond to the signal.

```
func _ready():
	MCP.connect("fadeTheUI", fadeTheUI)
	
func fadeTheUI():
	print("fadeTheUI called")
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")
```

Then the UI's AnimationPlayer fades the top UI component.

# Characters

## Hero

### Spawning

Each level has a Marker2D node named "TeleportIn". This is the starting position for the Hero on each level.
We set a timer (SpawnTimer) to fire when Hero scene is ready. When the timer expires, then the Hero script 
executes code  to make the Hero appear on the level.