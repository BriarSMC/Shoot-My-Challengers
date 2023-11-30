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
* Mcp (Master Control Program)
  * GameControlScreen
    * CreditsScreen
    * LoseScreen
    * SplashScreen
    * StartScreen
    * WinScreen
  * Level
    * Level1
    * Level2
    * Level3
    * Level4
    * Level5


# Level/UI Screen Transitions

## Animations

Each Level and UI Screen has an AnimationPlayer attached to it. The AnimationPlayer has two animations:
* FadeFromBlack
* FadeToBlack

FadeFromBlack plays automatically when the scene is loaded. The scene calls AnimationPlayer.play("FadeToBlack") 
when it's time to display another scene. Also, a method track is added to this animation. It's purpose is to 
emit a signal at the end of the animation to tell the MCP to change to the next scene.

## MCP 

>>>>>>>>>>>>>>>>>>>>ALL HAS TO BE REWRITTEN

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

When SMC instantiates a character it is inactive (`active: bool = false`). Hero becomes active when the spawning sequence is finished.
A Challenger becomes active when the Hero enters its Notice Area. 

## Scaling

We don't want to scale the whole scene; just the graphic. So, the node containing the character's graphic __MUST BE NAMED__
*CharacterImage*. This so the parent class (Character) can find the node in the tree and call Globals.scaleMe() for it.

## Notice Area

The Challengers each have a *Notice Area*. When the Hero enters this area, then the Challenger *sees* him and initiates the 
appropriate action(s). The collider for the notice area __MUST BE__ an Area2D so the `move_and_slide()` calls do not 
impede the Hero's movement.

## Taking Damage

Each character must have a function named `takeDamage(damage: int):`. Whenever a weapon collides with the character, then that
weapon will call this character's function with the amount of damage dealt. The character then deals with the damage appropriately.

## Hero

### Spawning

Each level has a Marker2D node named "TeleportIn". This is the starting position for the Hero on each level.
We set a timer (SpawnTimer) to fire when Hero scene is ready. When the timer expires, then the Hero script 
executes code  to make the Hero appear on the level.

### Moving

We use an object named HeroInputHandler to process all input from the player to manipulate the Hero. It is added
as a child of the Hero scene.

*__Polling v. _input(event)__* 

We tried doing event processing for moving, but we encountered some sort of lag. Therefore, we decided to use
Input polling for all inputs.

*__Hypnotized__*

When the Hero enters a Vampire's Notice Area, the Vampire will call Hero.hypnotize() with a pointer to the vampire
and a boolean on whether hypnotize is on or off. When hypnotize is on, then we set the Hero to inactive. This prevents 
the hero input handler from handling input requests. The Hero *slowly* walks to the Vampire and stops when it reaches the
Vampire. The Vampire will then bite (attack) the Hero. This also breaks the hypnotism. The Vampire calls Hero.hypnotize()
to end the hypnotism. The Hero will once again be active. We use `position += direction * speed * delta` to move the Hero.
This means the Hero will *pass through* any solid objects. We have to detect when we hit the Vampire in order to stop moving.


# Input Map

## Built-in Actions

These are the Godot Built-in Actions we've modified.

### ui_cancel

Added the Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -) to also serve as a cancel (`get_tree().quit()`).

# Weapon Instantiation

We instantiate weapons as we need them. We need to put them somewhere, so the Level class has a Node2D named WeaponsDeployed.
Its sole purpose is to the *home* fro instantiated weapons. During _ready() the Level class stores a pointer to this node
in *__Globals.weaponsDeployed__*. Any script instantiating a Weapon class must add it as a child to WeaponsDeployed.

```
Globals.weaponsDeployed.add_child(instantiated-object) 
```

## Hero's Primary Weapon

*__Interacting with Chests__*

Chests are RigidBody2D objects. Because of this, we cannot detect when its collider has been hit by the Hero's primary weapon.
So, the Hero's primary weapon detects if it hit a chest. If it does, then it calls the chest's open method.
