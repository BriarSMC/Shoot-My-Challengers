<!-- 
Contents of a Game Design Document Template for Any Video Game Development Project
----------------------------------------------------------------------------------

While the game design document template has changed a lot over the years, there are a few 
things that should be in all GDDs. While each GDD is slightly different from the next, they 
typically include the following. 

Executive Summary/Overview – It summarizes the entire game concept, genre, target audience, 
project scope, and game engine. 

Gameplay – Includes things like the objectives, user interface, game progressions, and 
overall style of the game (RPG, First-Person Shooter, Third-Person). 

Game Mechanics – Includes the combat styles, physics, rules, and more of the game world. 

Game Elements – Includes the game story, characters, locations, world building, level design, 
concept art, cut scenes, and more. 

Assets – These include all the 2D and 3D models, music, sound effects, and more. 

Others – Additional things can include the interface, AI system (Artificial Intelligence), 
technical information, and game art. 

While understanding the contents of a game design document is crucial, it’s best to use a 
GDD template to develop your game design document. 


Best Game Design Document Template You Can Use 
----------------------------------------------

Each game design document will be different from the others, but that doesn’t mean you can’t 
use a game design document template to get you started. 

As a game designer or programmer, you probably have a complete understanding of what you want, 
but it’s best to put it in a complete document. This is especially necessary if you’re making 
your first game, whether it’s a complete video game or a game for Android and iOS devices. 

In any case, you can use the following game design document template to get started. Each section 
has a description of what you should and can include in it. Furthermore, the template is numbered 
from the first part of the document to the last. 
-->

# Shoot My Challengers Game Design Document

## Short Description
Shoot My Challengers (SMC) is 2D, top down, 3rd-person shooter. SMC is designed for development on the Godot 4 game engine.

<!-- 
Every game design document starts with a title page for the sake of formalities. The title page has 
the game name, along with the game idea in a subtitle or high-concept sentence.

At times, when the game name isn’t fully determined, some potential game names are written. 
However, the title should be singular, and in this case, the title is the name of the project.

You can have a name for the game development project, such as ‘Project Shooter.’ The project name 
will serve as the game design document’s title until you finalize the game name.
-->

## Game Overview

Shoot My Challengers (SMC) is a demonstration of writing a simplistic 2D game using formal game development methods. 
This document is the first step in the formal methods. Others include Project Plan, Game Architecture Document, Game Implementation Document,
System Test Plan, Alpha Test Plan, Beta Test Plan, Game Development Notes, Project Notes, Release Notes, Standards and Conventions, and the GitHub repository to which this GDD
is attached.

We use Godot 4 for the game engine. Therefore, this document will use references to Godot 4 components.

The game is set in a medieval dungeon. The main player character (Hero) explores the dungeon, encounters challengers, defeats challengers, increases the score, collects items and power-ups. The whole goal is to kill enemies, collect items, and defeat all the level bosses.

The game has multiple levels (5 at this time). Each level has a 'boss'. Player must defeat the boss before moving to the next level.
Player collects items and power-ups by moving to their location and colliding with them. 

Winning the game is simply killing the boss on the last level. If the Hero dies, then the player loses.

The visual style is that of a retro 8-bit game. While the graphics are more refined than 8-bits, the overall feel of the game is retro.

### Intended Audience

* Experienced Game Players
* Game Developers at any level
* Graphics Artists
* Story Writers

<!-- 
The game overview is often the second part of the GDD that summarizes the entire project and game idea. 
Different games tend to have varying game overviews, depending on the idea of the game. For example, 
if it’s a sequel to an existing game, the game overview would include what the upcoming game would entail.

In any case, the game overview starts with the game concept, detailing the ultimate goal of the game and 
the inspiration for it. After that, you have to explain the genre of the game, for example, if it’s 
a sports game, shooter game, SF game, or any other genre.

After that, you briefly describe the target audience of the game. You can either list the potential 
age group or a specific set of gamers.

It’s also crucial to include the game flow summary that details how the player will progress through 
the game. This includes the framing interface and the entire game itself.

Lastly, you have to briefly describe the look and feel of the game by detailing the visual art style, 
background setting, and backdrop.
-->

## Game Play and Mechanics

###  Game Play

#### UI

__Game Loading (Splash Screen)__

The first image the player will see is the 'game loading' splash screen. This is a generic screen with game's name,
game's logo, and 'Loading..." text. Usually, this will be just a flash until the game start screen displays.

__Game Start__

This screen is displayed when the game has been loaded/reloaded and is ready to play. It is a screen displaying
'Start Game', 'Exit Game', and 'Game Credits' buttons. When the player clicks the 'Start Game' button, then the game
starts by loading and displaying the Level-1 Scene. When the player clicks the 'Exit Game' button, then the game
immediately exits to the hardware's operating system.

__Game End__

The game ends whenever the hero defeats the boss on the final level, or the hero's health points fall to zero or less. 
When this happens the game will display the Game Over screen, then after a short time (seconds), the screen will
fade to the Game Start screen. The game end screen will display whether the Hero was successful or died.

__Credits Screen__ 

The Game Credits screen will display all accreditation due either by good will or license requirement. If needed, 
the credits will scroll to accommodate their number.

Current credits can be found in [Game Credits](https://github.com/CoghillClanCoding/Shoot-My-Challengers/wiki/Game-Credits)


__Level Screens__

During game play each level will display a UI containing critical stats. They are:

* Maximum health,
* Current health,
* Challengers Defeated, 
* Coins collected,
* Gems collected,
* Shield counts,
* Primary weapon ammo count, and
* Secondary weapon ammo count.

#### Levels

The game play consists of 5 levels. When the player starts game play (Start Screen), SMC displays the first level (Level 1). 
Levels are larger than the game viewport. At the beginning of a level the viewport contains the portion of 
the level the Hero will start from. SMC blocks the player's input until the Hero's spawning process is complete.

The Hero character is not visible when the level loads and displays. At a preset time the game shows the Hero in the viewport using
an effect akin to using a teleport. When the Hero character finishes with the teleport, then SMC enables
the player's controls so the player can interact with the game.

The player controls the Hero to move around the level (exploring). While doing this the player encounters
__Containers__ (which contain items), __Power-ups__, and __Challengers__. The  player can:

* Open containers,
* Collect the contents of open containers,
* Collect power-ups, and
* Fight challengers.

The final goal of each level is to defeat the *Boss* character (Skull of Death). The player cannot move
to the next level until the Boss is defeated. When the player defeats the boss, then SMC will fade to the next
level. On the last level, then SMC will display the Game End screen.

If at any time a Challenger defeats the Hero, then the player loses and the game is over  and SMC will display the
Game End screen. 

### Level Difficulty

This game is not meant to be difficult to play or win. It is a demonstration of what can be done. 
However, the last 3 levels will have more Challengers and more difficult bosses. More difficult. Not ridiculous. 

### Options

This game has no options the player can select.

#### Characters

* The Hero (Protagonist)
  - Primary Weapon: Crossbow Bolt
  - Secondary Weapon: Bomb
  - Defense:
    + Short Shield
    + Long Shield
* Vampire (Challenger) : Easy
  - Primary Weapon: Bite
  - Secondary Weapon: Automatically draws Hero to the Vampire in a helpless state
* Skeleton Warrior (Challenger) : Moderately easy
  - Primary Weapon: Throwing Knife
* Skeleton Grim Reaper (Challenger) : Medium
  - Primary Weapon: Fireball
  - Secondary Weapon: Scythe
* Skull of Death (Challenger) : Hard (Level Boss)
  - Primary Weapon: Laser
  - Secondary Weapon: Leap and Fire blast

#### Containers

These objects contain items. The game developer/coder and the designer statically place these during 
level design and development. The contents of each container are handled the same. 
They are closed when the player starts a new level. 

The player opens a container by shooting it
with the Hero's primary weapon. When the weapon hits the container, then the container opens by
displaying an animation of it opening, and SMC shows the items on the screen. SMC displays the items
such that the are a short distance from the container and the player can easily *pick them up* by 
moving the Hero graphic so that it collides with the items.

* Large Chest
* Medium Chest
* Small Chest

#### Items

Items only appear in containers. Gems and coins serve no purpose other than giving the
player a sense of accomplishment by collecting them. Collecting gems and coins only
increases their respective counters in the UI.

* Increase maximum health by 10 and fill set health to maximum health,
* Gems, and
* Coins.

#### Power-ups

SMC generates power-ups randomly. SMC randomly generates a power-up between 1 and 10 seconds.

The following list shows each power-up, the probability of SMC
generating it, and its value.

* Extra life points 
  - 25% probability
  - 5 to 10 life points
* Primary weapon refill of 5 units
  - 30%
  - 5 units
* Secondary weapon refill of 1 unit
  - 15% probability
  - 1 unit
* Short Shield
  - 20% probability
  - 1 unit
* Long Shield refill
  - 10% probability
  - 1 unit

#### Level Layout and Decorations

__Level 1__

*Content*

* Challengers
  - 2 Skeleton Warriors
  - 0 Skeleton Grim Reapers
  - 1 Vampire
  - 1 Skull of Death
* Containers
  - 1 Small Chest
    + 1 Short Shield
    + 1 Coin
    + 1 Primary Weapon
  - 1 Medium Chest
    + 2 Primary Weapons
    + 1 Life Potion
  - 2 Large Chests
    + 5 Primary Weapons
    + 3 Secondary Weapons
    + 2 Life Potions
    + 1 Long Shield

*Layout*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/Level-1MockUp.png)

The Front Room has 2 Skeleton Warriors, 
1 Vampire, 1 Small Chest, 1 Medium Chest, and 1 Large Chest. The Vampire blocks the doorway between both rooms
so that the player must defeat the Vampire to get to the boss.

The Back room has the Skull of Death and 1 Large Chest. The Skull of Death is at the back of the room and Large Chest
is near the front of the room so that the player can retreat and open the Large Chest if needed.

__Levels 2 & 3__

*Content*

Same as Level 1.

*Layout*

Same as Level 1 with different positions for the containers, items and Skeleton Warriors.

__Level 4__

*Content*

* Challengers
  - 6 Skeleton Warriors
  - 1 Skeleton Grim Reapers
  - 2 Vampires
  - 1 Skull of Death
* Containers
  - 3 Small Chests
    + 2 Short Shield
    + 2 Small Coin
    + 2 Primary Weapon
    + 1 Gem
  - 3 Medium Chests
    + 2 Primary Weapons
    + 1 Small Life Potion
    + 1 Large Coin
    + 2 Gems
  - 2 Large Chests
    + 1 Increase Maximum Life
    + 5 Primary Weapons
    + 3 Secondary Weapons
    + 2 Large Life Potions
    + 2 Long Shield

*Layout*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/Level-4MockUp.png)

__Level 5__

*Content*

* Challengers
  - 12 Skeleton Warriors
  - 2 Skeleton Grim Reapers
  - 4 Vampires
  - 1 Skull of Death
* Containers
  - 8 Small Chests
    + 1 Life Potion
    + 2 Short Shield
    + 2 Small Coin
    + 2 Primary Weapon
    + 1 Gem
  - 4 Medium Chests
    + 2 Primary Weapons
    + 2 Secondary Weapons
    + 1 Small Life Potion
    + 1 Increase Maximum Life
    + 1 Large Coin
    + 2 Gems
  - 4 large Chests
    + 1 Increase Maximum Life
    + 2 Life Potions
    + 10 Primary Weapons
    + 5 Secondary Weapons
    + 3 Large Life Potions
    + 2 Long Shield

*Layout*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/Level-5MockUp.png)

<!-- 
The gameplay and mechanics are some of the most crucial parts of the game design document. This is where 
you have to explain everything about the game and sell it to whoever is reading the GDD.

Since plain text can’t accurately convey everything about a game, it’s best to use some visuals, rudimentary 
graphics, and models/examples to portray your points more effectively.
-->





<!-- The gameplay will include everything from the final player’s perspective. That means that you have 
to start off by explaining the game’s progression. From the starting point to the setting of the entire 
game and how each aspect will affect the player’s progression should be included.

Furthermore, it should detail the missions, side missions, and the challenge structure. If you include 
various difficulties, you’ll have to explain how it will impact the game on each difficulty. If the game 
includes puzzles, you’ll have to explain the puzzle structure.

Lastly, you have to explain the various objectives of the game and the overall play flow. For example, 
the objective of the game can be to develop a good reputation, visit each point on the map, and find 
the lost treasure. You have to also explain how each objective will affect the game flow for the game player.
-->

### Mechanics

<!-- The game mechanics are simply the explicit and implicit rules of the game. It includes the game systems, 
the universe, and how the game pieces interact with each other. In most cases, this section can be the 
longest, especially if it deviates from real life because then you have to explain how each mechanic will 
work in the new universe you’ve created.

The mechanics above will determine the setting of the game.
The following are the key things to mention in the game mechanics section.
-->

#### Physics

Levels differ in size and area. Each level will have a boundary wall to prevent the player from
moving the Hero out of the level's area, and to prevent game controlled characters and objects
 from leaving the level's area. 

Since this is a top down game, gravity is not used, nor can the Hero or any computer controlled character jump.
Nor do projectiles fall to the floor.

The Hero moves about the area in response to the player's inputs on the controls. Hero's speed
is constant. No power-ups exist to boost or retard speed. 

Any object that would be solid in-real-life is also solid in SMC. Hero, NPCs, projectiles and weapons cannot 'pass through'
solid objects.

Weapons and projectiles travel in straight lines from point of release.

Bombs remain where they are placed.

__Notice Range__ - Some Challengers do not engage with the Hero until the Hero enters their notice range. This is
an area (usually circular) around the challenger that causes the Challenger engage with Hero for combat. The Challenger
moves towards the Hero until the Hero is in range of the Challenger's weapon(s). The notice range is greater than the
crossbow's projectile range. The player can choose to fight the Challenge, or try to run away from it, or try to put
an object between the Hero and Challenger.

<!-- 
It’s critical to explain the physics of the game to set up the game world. If it’s set in real 
life or close to it, this section can be completed easily. However, if you’re making up a fantasy 
world, cartoon world, or a new universe, you need to explain how physics will work in each case.
-->

#### Movement

The player controls the Hero's movements. NPCs movements are controlled by the game logic.

The AI controls movement for the Challengers.

<!-- 
The movement of objects is directly related to the physics of the game. You can only start on this section after 
listing the physics requirements.
-->

#### Objects

These include:
* Containers,
* Items, and
* Power-ups.

Only the Hero can collect items and power-ups. The player collects items by firing the primary weapon at a container. The container 'opens' and
displays the items it contains. The player then collects the items by colliding with them. 

The player collects power-ups by colliding the Hero into them. Items (Containers) that contain other items such as prizes and power-ups
cannot be opened by Challenger weapons.

<!-- 
This part only focuses on how each object can be picked up, how it will move, and what it will look like. 
-->

#### Actions

SMC will support keyboard/mouse and a game controller. The player can interact with the UI and controls the Hero with 
these input devices.

##### UI Interaction

The sole interaction with the UI is clicking buttons on the Start, End, and Credits screens. When using the keyboard/mouse the 
player uses the left mouse button to click on buttons. The player can select the following buttons:

* Game Start
  - Start Game - A button
  - Exit Game - X Button
  - Credits - B Button
* Game Exit
  - Return to Start - A button
* Credits
  - Return to Start - A button

##### Hero Control

__Keyboard/Mouse__

* Move Left - A or Left-arrow
* Move Right - D or Right-Arrow
* Move Up -  W or Up-Arrow
* Move Down - S or Down-Arrow
* Primary Weapon - Left Mouse Button
* Secondary Weapon - Right Mouse Button
* Shields - Q

__Game Controller__

* Movement - Left Joystick
* Aim/Move Target Pointer - Right Joystick
* Primary Weapon - Right Trigger
* Secondary Weapon - Left Trigger
* Shields - Left Shoulder Button or Right Shoulder Button

##### Viewport

The levels are larger than the viewport for the game. The Hero is always at the center of the viewport. As the player
moves the Hero the level scrolls to keep the Hero in the center of viewport. (I. E. The camera is always above the
Hero.)


<!-- 
This part includes how the player will interact with the world, including the objects, switches, buttons, 
NPCs (Non-Player characters), and more. 
-->

#### Combat

__Cool Down Period__ - The game limits combatants to how often they can fire their weapons. This is referred to as
the cool down period. When a combatant fires a weapon, then it cannot fire that weapon again until the cool down
period has expired.

__Damage Immunity Period__ - The game limits how often a combatant can be hit by an opponent's weapon. When a weapon inflicts
damage on a combatant, then that combatant cannot be damaged again until the damage immunity period has expired.

##### Hero

*Movement* - Controlled by player. SMC has four (4) sprite images for the Hero; North, East, South and West. SMC determines
the general direction of the Hero's movement and displays the appropriate image.

*Damage Immunity Period* - The Hero has a preset damage immunity period.

*Primary Weapon* - Crossbow. This is a traditional distance, projectile weapon. When fired at an Challenger it inflicts a
preset amount of damage. When a crossbow projectile hits a container, then the container opens to reveal its contents. This 
weapon is subject to a preset cool down period. 

*Secondary Weapon* - Bomb. This is a stationary weapon placed by the Hero. It detonates 2 seconds after being placed. The 
detonation inflicts a preset amount of damage. The projectile has a preset range after which it is removed from the scene.
This weapon is subject to a preset cool down period. 

*Short Shield* - This makes the Hero immune from damage for a preset amount of time. This shield cancels any damage immunity
period that may be active. No other shields can be used while this one is active.

*Long Shield* - This makes the Hero immune from damage for a preset amount of time which is longer than the short shield.
This shield cancels any damage immunity period that may be active. No other shields can be used while this one is active.

*Empty* - If the player activates the Primary Weapon/Secondary Weapon/Short Shield/Long Shield and the inventory count is zero (0),
then nothing happens except of an empty sound being played.

##### Vampire

*Movement* - None.

*Damage Immunity Period* - None.

*Primary Weapon* - The stare and bite. When the Hero comes within a preset range (notice range) of the vampire, then the Hero comes under
the vampire's control (the stare). This causes the Hero to move to the vampire's position. When they collide, the vampire bites
the Hero inflicting a preset amount of damage. At this point the vampire's control over the Hero ends and the vampire cannot
control the Hero until the cool down period expires. This allows the Hero to plant a bomb and back out of range. 
NOTE: The preset range of the stare is greater than the range of the crossbow projectile. This forces the Hero to have to 
place a bomb to destroy the vampire. 

##### Skeleton Warrior

*Movement* - When the Hero enters it's notice range, then the Skeleton Warrior moves towards
the Hero in order to use its primary weapon. If the Hero leaves the notice range, then the challenger stops moving and remains 
where it is. The Skeleton Warrior is pretty brain-dead. It it encounters an obstacle (solid object) directly in the path to the
Hero, then the object stops the Skeleton Warrior and it cannot proceed along that path. It can only move if the Hero moves so 
that no objects are between the Hero and the Skeleton Warrior, and the Hero is still in the Skeleton Warrior's notice range.

*Damage Immunity Period* - A preset amount of time, but is relatively short.

*Primary Weapon* - Throwing Knife. The Skeleton Warrior throws a knife at the Hero when it is within a preset distance from the
Hero (throwing range). The knife has a cool down period of one (1) second. This weapon is subject to a preset cool down period.
If the knife hits the Hero, then it inflicts a preset amount of damage. The knife has a preset range. If it 
does not hit the Hero, then it is removed from the scene if it exceeds this range.

##### Skeleton Grim Reaper

*Movement* - This Challenger is a hunter. By this we mean that it seeks out the Hero whenever the Hero enters its domain (as defined by a 
navigation region). When the Hero moves into this region, then the Skeleton Grim Reaper moves towards the Hero. However, unlike the Skeleton
Warrior, objects (solid objects) do not deter it. The Skeleton Grim Reaper will move around obstacles to reach the Hero. If the Hero leaves
the Skeleton Grim Reaper's domain, then it will stop moving.

*Damage Immunity Period* - A preset amount of time, but longer than the Skeleton Warrior.

*Primary Weapon* - Fireball. When the Hero is in range of this weapon, then the Skeleton Grim Reaper will throw a fireball at the Hero.
The range is such that the Hero will be hit at least once by the fireball. When the fireball leaves its range, then it is removed from 
the scene. The fireball is subject to a preset cool down period. The fireball inflicts a preset amount of damage. The speed of the 
fireball is such that the Player will have difficulty dodging it.

*Secondary Weapon* - Scythe. When the Hero becomes closer to the Challenger, then the challenger switches to its secondary weapon. 
This weapon has a higher damage value than the primary weapon, and it is subject to a preset cool down period.

##### Skull of Death

*Movement* - This Challenger does not move more than a preset distance from where it starts in the scene. No obstacles are
in this diameter of movement, so that the Challenger always has a clear path towards the Hero. When the Hero enters this area, 
then the Challenger attacks the Hero immediately.

*Weapon Selection* - The game logic randomly determines which weapon will be used. A preset value determines the probability
of which weapon is used. The primary weapon has a higher probability of being used than the secondary weapon. Because of this
the secondary weapon inflicts a higher amount of damage. 

*Damage Immunity Period* - A preset amount of time to make it challenging for the player. The last few levels have a 
longer preset time. 

*Primary Weapon* - Laser. When the Hero is in range of the Challenger, then the Challenger fires this weapon. It is fast. 
So the Hero cannot dodge it. The laser has a preset amount of damage. The laser is subject to a longish preset cool down period.

*Secondary Weapon* - Fire blast. When the secondary weapon is selected, then the Challenger lunges (moves quickly, very 
quickly) towards the Hero. It then sends a fire blast at the Hero. The fire blast has a higher preset amount of damage than the 
laser. This weapon is subject to the same cool down period as the laser.

<!-- 
While some games don’t have any combat or conflict involved, the ones that do need to explain the combat mechanics. 
-->

#### Economy

No real economy exists in SMC. Although the player can collect gems and coins, they have no value in the game other
than bragging rights.

The only reason we included them is in case we develop this game further and include a real economy.

<!-- 
It’s crucial to explain how the game economy works and what currencies and valuables will be used.
-->

#### Screen Flow

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/ScreenFlow.png)


When the player activates the game, then SMC displays the splash screen. Once the game is loaded, SMC displays the 
Game Start screen. 

From the Game Start screen the user can choose start a game, exit the application to the O/S, or display the game credits.

Game Credits display all the credits for the games. If all credits do not fit on the screen, then the screen will scroll. The
screen has a "Return" button to go back to the Game Start screen.

SMC displays the Game End screen when the player either wins or dies. It has a "Continue" button to go back to "Game Start".

<!-- 
This part graphically helps explain how each game screen is related to the next. It’s useful to explain how 
loading screens, main menus, and more will work.
-->

### Other Gameplay Aspects

* SMC has no pause capability
  
<!-- 
While the gameplay and mechanics are important to explain, it’s also essential to explain some additional 
aspects of the game, including the following.

After giving a complete overview of the gameplay and mechanics, you can move on to story building.
-->

#### Gameplay Options

SMC has no options for the player to choose from.

<!-- 
You should mention all the game options and how they affect gameplay and mechanics in different cases. 
For example, some games allow you to change the physics of the game to play around.
-->

#### Saving and Replaying

SMC does not include saving games. Reply consists of starting the game over.

<!--
It’s important to detail how the saving, auto-saving, replaying, checkpoints, and mission restarts will work.
-->

#### Easter Eggs and Cheats

N/A at this time.

<!--
Each game has some sort of subliminal message, Easter eggs, and cheats. If you want to include them, this is the time to mention them.
-->


## Setting, Story, and Characters

### Setting

The game is set in a medieval castle's dungeon. The each level of the dungeon can contain the following items,
power-up, and Challengers:

* The Hero,
* Challengers,
  - Vampire,
  - Skeleton Warrior,
  - Skeleton Grim Reaper,
  - Skull of Death (Boss),
* Containers (chests of various sizes; larger chests may hold multiple items),
  - Gems,
  - Coins,
  - Power-ups,
    + Healing potions,
    + Primary weapon ammo refill,
    + Secondary weapon ammo refill, and
    + 5 second Short Shield,
    + 10 second Long Shield,
* Decorations,
* Power-ups will also be spawned randomly on each level.

### Story

This game has no story. It simply has a Hero who explores the dungeon, collects items, and fights the Challengers. 
Defeating the Boss allows the Hero to 'teleport' to the next level, or end the game on the final level, or die (thus
ending the game).

### Characters

#### The Hero

This is the player's character. The Hero is the protagonist. The player controls the Hero's movement, collection of items
and power-ups, and combat. 

##### Properties

- *Primary Weapon* - Crossbow that shoots projectiles.
- *Secondary Weapon* - Bombs.
- *Shields* - Give the Hero immunity from damage
- *Health* - The hero starts out at maximum health. Maximum health can be increase by picking up items from containers.

Note on shields: SMC has two types of shields; A short shield and a long shield. The game keeps separate inventory counters
for each. When the player presses a shield button, then SMC uses a long shield. When they are depleted, then SMC uses the
short shield. When both are depleted, then no shields are deployed.

#### Vampire

The Vampire is a stationary Challenger. Its primary purpose is to block the passage of the Hero. Being a solid object, it
will also block other Challengers. 

##### Properties

- *Primary Weapon* - Stare and bite.
- *Health* - The vampire's starting health should be less than that of a bomb's damage.

#### Skeleton Warrior

The Skeleton Warrior is a simple Challenger. When it notices the Hero it moves towards the Hero to attack him.

- *Primary Weapon* - Throwing Knife.
- *Health* - The starting health of the Skeleton Warrior is such that it can withstand being shot by several crossbow projectiles.
However, a single bomb kills the Skeleton Warrior.

#### Skeleton Grim Reaper

The Skeleton Grim Reaper is a medium challenger. 

- *Primary Weapon* - Fire ball.
- *Secondary Weapon* - Scythe. 
- *Health* - The staring health of the Skeleton Warrior is such that it can withstand being shot by many crossbow projectiles, and
it can only be killed at full health by two (2) bombs.

#### Skull of Death

The Skull of Death is a hard challenger.

- *Primary Weapon* - Laser.
- *Secondary Weapon* - Fire blast. 
- *Health* - The starting of this Challenger is fairly high. It should withstand many, many projectile hits, and
many bombs. The  last few levels should have a higher starting health value.

<!--
This section focuses on setting up the game world, narrative, and story. That includes the back story, 
ongoing story, prologue, epilogue, plot elements, game progression, and cut scenes. The cut scenes include 
the description and setting of the script, story-line, storyboard, and actors.

The section also includes a description of the game world and what it looks and feels like. For example, 
if the game is based in the mountains, you would have to explain what each area would look like and how 
it will relate to the rest of the world.

You also have to explain how it connects to each area and what levels it will be used in.

Lastly, you have to write about all the game characters, their back story, appearance, personality, 
characteristics, animations, abilities, and their relation to other characters. At this point, the main 
character should be done first, followed by the characters directly related to the main character.
-->

<!--
This section focuses on the levels of the game; each level would include a synopsis, introductory material, 
objectives, and details of the level. If it’s a linear game, you would have to physically describe the map 
at each level, the path of the player, and what they will encounter.

In a non-linear game, this section will focus on the level-up system for the player’s character, 
including information on the power-ups, weapon upgrades, and more. It’s best to show this progression 
using a flow chart.

Furthermore, you should also explain how the training level or tutorial will work in this section.
-->

## Game Interface

### Game Control UI

__Fonts__ - The only font used on these screens is Tahoma or equivalent.

__Music__ - Background music: This will play whenever a Game Control UI screen is displayed. No disruption 
of the music's continuity will occur as the player navigates between these screens.

__Sound Effects__ - Button Clicks: 

#### Start Screen

The player can select whether to play the game, exit the game or view the game credits.

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/StartScreenMockup.png)

#### Game Over

__Sound Effect__ - Played only once. No looping.
  * Win
  * Lose

SMC will display one of two screens depending on whether the player won or lost the game. The only option
on either of these screens is to continue (display the Start Screen).

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/GameEndScreenWinMockUp.png)

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/GameEndScreenLoseMockUp.png)

#### Game Credits

When the player clicks on Game Credits from the Start Screen SMC will display this screen. The only option
on either of these screens is to continue (display the Start Screen).

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/GameCreditsMockUp.png)

### Levels

__Music__ - Each level will play this music, on loop, from tree insertion to tree removal. It may be
paused or volume adjusted by objects in the scenes. The background music is replaced when the player
engages the boss in combat.

__Sound Effects__ - SMC will play this effect when the Hero does a teleport to enter and exit each level.

### Hero

__Music__ - No music for this character.

__Sound Effects__ 

  * Crossbow (Primary Weapon) - Plays when the player triggers the input for this weapon. 
  * Bomb (Secondary Weapon) - 
    - Impact sound: Plays when the player triggers the input for this weapon.
    - Explosion sound: Plays when the bomb explodes.
  * Shield: Humming sound while shield is active
  * Death - Plays when Hero dies.
  * Empty Inventory - Plays when the player tries to activate something that has a zero (0) inventory count.

### Vampire

__Music__ - Plays when the Hero enters the vampire's notice range. SMC lowers the volume
of the Level background music while this is playing.

__Sound Effects__ 

  * Vampire bites the Hero.
  * Vampire dies.

### Skeleton Warrior

__Music__ - No music for this character.

__Sound Effects__ 

  * Character is walking.
  * Character dies.
  * Character throws primary weapon.

### Skeleton Grim Reaper###

__Music__ - Played when the Hero enters characters 
navigation region. It must tell the background music to lower its volume so that this music is
more dominant. When this character dies, or the Hero leaves the navigation region, then this music 
stops, and we must tell the background music to resume normal volume.

__Sound Effects__ 

  * Character uses primary weapon.
  * Character uses secondary weapon.
  * Character dies.

### Skull of Death

__Music__

When the Hero first engages (enters the boss' notice area) the boss, we then tell the background music to
pause and start playing the boss battle music. Even if the Hero leaves the notice area, then the music 
continues playing. It stops only when either the boss dies or the hero dies. Each level has its own 
boss music.


__Sound Effects__ 

  * Character uses primary weapon.
  * Character uses secondary weapon.
  * Skull of Death dies. Each level has its own sound effect for this.

### Chests

__Sound Effects__ - Plays when a chest opens.

__Animation__ - A animation of the chest opening. Once opened it stays static on the last image of the animation.



### Items

__Sound Effects__

* Hero picks up a coin.
* Hero picks up a gem.
* Hero picks up a Life Potion.
* Hero picks up a Maximum Life Potion.

### Power-ups

__Sound Effects__

* Primary Weapon reload.
* Secondary Weapon reload.
* Short Shield.
* Long Shield.


<!--
The game interface is what the player will see on their screen in different cases. The visual system of 
any game may include a HUD – you’ll have to explain what the HUD will show, where it will be placed, and 
what the fonts, icons, and animations will be like.

You’ll also have to explain what menus will be shown in different cases and what the camera model and 
angles will be like.

Furthermore, you would have to explain the control system of the game. This includes information on how 
the player will control the game, what commands there will be, and how the buttons will work.

Lastly, it’s crucial to list all the audio, music, and sound effects that will be included. Also, if 
there is a help system, you’ll have to explain how it will assist the player.
-->

## AI

There isn't much in the way of AI for this game. 
<!--
The AI of the game is how the NPCs react and act in different cases. You have to explain how the opponent 
and enemy AI reacts in different cases to provide a more realistic approach.

Furthermore, you have to set up the AI system for friendly and other non-combat characters, including 
animals, plants, and other systems.

Lastly, you have to explain the programming for the supporting AI – this is used for path-finding, player 
detection, collision detection, hit detection, and more.
-->

## Technical Aspects

<!--
The second-last part of your game design document will detail the technical aspects of the game. This 
isn’t necessarily about the game itself but aims to explain the technical requirements of the game for 
the player base.

The following are some of the technical aspects you should focus on explaining.
-->

### Target Hardware

SMC is played on Windows 10/11 PCs only.

<!-- 
This part focuses on the overall game requirements. You have to explain what kind of hardware the game 
is targeted towards. It’s best to list down the minimal requirements and the recommended requirements. 
The requirements should include the estimated game size and compatibility information.
-->

### Game Engine

Godot 4.

<!-- 
If the game is based on a new game engine, you have to explain how the game engine was developed and 
what hardware and software were used.
-->

### Network Requirements

None.
<!-- 
This part explains the overall network/internet requirements, especially if the game has a multiplayer component.
-->

## Game Art

### Graphics

*__Tileset__*

This is the tileset we are using to build our levels.

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/Dungeon_Tileset_v2.png)

#### Hero

*__Idle__*
No animation. 

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero.png)

*__Walking__*

South 

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero_walk_south.gif)

West

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero_walk_west.gif)

North

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero_walk_north.gif)

East

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero_walk_east.gif)


*__Combat__*
Primary Weapon

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/hero_p_weapon.png)

Secondary Weapon 

*__Animation__* - SMC will animate a lit fuse on the bomb. 

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/bomb.png)


#### Vampire

*__Idle__*
Vampire's idle animation is controlled by a AnimationPlayer attached to the Sprite2D.

*__Walking__*
None.

*__Combat__*
None.

#### Skeleton Warrior

*__Idle__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_idle.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_idle.gif)

*__Walking__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_walk.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_walk.gif)

*__Combat__*

Primary Weapon

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/knife.png)

Secondary Weapon

None.

#### Skeleton Grim Reaper

*__Idle__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_gr_idle.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_gr_idle.gif)

*__Walking__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_gr_walk.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skeleton_gr_walk.gif)

*__Combat__*

Primary

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/fireball1.gif)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/explosion1.gif)

Secondary

SMC will animate this weapon's actions

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/scythe.gif)

#### Skull of Death

__Idle__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skull_idle.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skull_idle.gif)

*__Walking__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/skull_walk.png)

*__Combat__*

Laser

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/laser.png)

Fire Blast

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/fireblast.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/fireblast.gif)

#### Large Chest/Medium Chest

*__Idle__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/chest_1-closed.png)

*__Animation__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/chest_1x5.gif)

#### Small Chest

*__Idle__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/chest_2-closed.png)

*__Animation__*

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/chest_2.gif)

#### Increase Maximum Health
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/maximum_life_potion.png)

#### Gem
SMC sets the gem image randomly when it is instantiated.

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/gem4.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/gem6.png)
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/gem12.png)

#### Coin
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/coin.gif)

#### Extra life Points
![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/health_extra_life_points_potion.png)

#### Primary Weapon Refill
*__Animation__* - SMC will cause the gem in the image to rotate.

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/health_extra_life_points_potion.png)

#### Secondary Weapons Refill
*__Animation__* - SMC will use an AnimationPlayer to make this graphic bob up and down

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/bomb.png)

### Short Shield Refill
*__#Animation__* - SMC will use an AnimationPlayer to make this graphic bob up and down

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/short_shield.png)

#### Long Shield Refill
*__Animation__* - SMC will use an AnimationPlayer to make this graphic bob up and down

![](https://coghillclan.net/ImageLibrary/ShootMyChallenger/images/long_shield.png)

### Music

* UI
  - Background Music: *Eyes of Glory.mp3*.
  - Sound Effects: 
    + Button Click: *Retro Explosion UI 01.mp3*
* Levels
  -  *Heads Up - The 126ers.mp3*
  - Bosses
    + Level 1: *507307__matrixxx__the-battle-between-scorpio-and-orion.mp3*
    + Level 2: *510953__theojt_cinematic-battle-song.mp3*
    + Level 3: *676998__snowfightsstudios__fight-music-synth-tense-loop.mp3*
    + Level 4: *352171__sirkoto51__boss-battle-loop-1.mp3*
    + Level 5: *591500__klavo1985__saying-good-bye-before-battle-music-for-war-game-in-vr.mp3*
* Challengers
  - Vampire: *Retro Instrument - choir bass - C11.mp3*
  - Skeleton Grim Reaper: *516439__wolfdoctor__ominous-whistling.mp3

### Sound Effects

* Game Over
  - Player Wins: *1940_s_Slow_Dance_Sting.mp3*
  - Player Loses: *Retro Explosion Long 02.mp3*
* Level
  - Teleport: *Retro Jump StereoUP Simple 01.mp3*
* Hero
  - Primary weapon: *Retro Weapon Arrow 02.mp3*
  - Secondary weapon: 
    + Impact: *REtro Impact Metal 05.mp3*
    + Explosion: *Retro Weapon Bomb 06.mp3*
  - Shield: *44823__timkahn__dronnee.mp3*
  - Empty: *419023__jacco18__acess-denied-buzz-amplified.mp3*
  - Death: *572335_jarl_fenrir_dies-irae.mp3*
* Vampire
  - Primary weapon: *268501_bernuy_vampire-bites.mp3*
  - Death: *703317_beetlemuse_zamn-scream.mp3*
* Skeleton Warrior
  - Walking: *188034_antumdeluge__bones-2.mp3*
  - Primary weapon: *703708__strangehorizon_thowing_arm_3.mp3*
  - Death: *704635__zulfish_monster-dying.mp3*
* Skeleton Grim Reaper
  - Primary weapon: *539927__za-games__fire-burst-slash.mp3*
  - Secondary weapon: *706678__sadiquecat__whoosh-bamboo-3.mp3*
  - Death: *660111__matrixxx__purge-remastered.mp3*
* Skull of Death
  - Primary weapon: *523205__matrixxx__retro-laser-gun-shot.mp3*
  - Secondary weapon: *5555519__eminyildirim__mage-fireball-skill.mp3*
  - Death
    + Level 1: *522572__matrixxx__retro-bomb-explosion.mp3*
    + Level 2: *414209__jacksonacademyashmore__death.mp3*
    + Level 3: *483693__camauflaged_noob__weird_death.mp3*
    + Level 4: *415079__hariietniamh__video-game-death-sound-effect.mp3*
    + Level 5: *257796__xtrgamr__flatline.mp3*
* Containers: *270316__littlerobotsoundfactory__open_00.mp3*
* Items
  - Coin: *444918__matrixxx__ping.mp3*
  - Gem: *481151__matrixxx__cow-bells-01.mp3*
  - Life Potion: *523651__matrixxx__powerup-05.mp3*
  - Maximum Life Potion: *523649__matrixxx_powerup-07.mp3*
* Power-ups
  - Primary weapon refill: *396331__nioczkus__1911-reload.mp3*
  - Secondary weapon refill: *500294__bratish__shotgun-reload.mp3*
  - Short shield: *523753__matrixxx__new-skill-01.mp3*
  - Long shield: *523745__matrixxx__armor-02.mp3*


<!-- 
The last section of your game design document detail the game art and models being used. This includes 
all the key assets of the game, including character models, buildings, objects, environments, and more.

It’s crucial to explain how each model is being developed, who’s developing it, whether you’re outsourcing 
it, and how many assets there are in total. You also have to give an idea of the intended style for each asset.

It’s best to attach multiple screenshots of assets that have been prepared or are in the process of being 
developed to provide an idea of what’s to come.

This section serves as a benchmark for development and also a base that helps modify any assets if the need comes.
-->

