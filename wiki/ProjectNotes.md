This is very unorganized at the moment. Just stuff that I'm documenting as I build this project.

## 11/10/2023 - Sprite Scaling
The sprite set I'm using uses 16x16 sprite sheets. In other words...tiny. I'm making a full-screen game for a PC. So they don't
show up very well. Actually they are pretty much just a dot on the screen. Current solution:

*__Globals.gd__*

Created this autoload script. 
```python
extends Node

@export var scaleByBase: float = 3.0
var scaleBy: Vector2 = Vector2(scaleByBase, scaleByBase)

func scaleMe(me, additionalScale: float = 1.0) -> void:
	print("scaleMe called by ", me.name)
	me.scale = scaleBy * additionalScale
```

*__Instance attached script__*

Each graphic that uses one of these sprite sheets must adjust its scale by using the following in its attached script:

```python
func _ready():
        Globals.scaleMe(self)

```
or
```python
func _ready():
        Globals.scaleMe(self, n.m)

```
The first version scales the sprite by whatever scale factor is set in Globals.scaleByBase. Since there is one case (LargeChest and MediumChest) where I am using the same sprite sheet for both objects, then I need to make LargeChest slightly larger then the MediumChest. The second version allow me to adjust the scale as needed.

## 11/10/2023 - Turning Sprite Sheet GIF

We need a way to show sprite animations in the documentation. We turn the PNG sprite sheet into a single GIF. 
These are the steps we take to make a GIF out of a sprite sheet:

1. cd to the image's directory
1. Run the convert command:
  ```
  convert -dispose number-of-frames -delay  centicesconds-per-frame -loop 0 file.png -crop nxm +repage file.gif  
  ```
  >
  > Where number-of-frames is an integer, centiseconds-per-frame is an integer, and nxm is the dimensions of the PNG sprite in pixels. 
3. Enlarge the image by 5x
1. Edit the file.gif with gimp. Use gimp to change the delay of the last frame to 1500 milliseconds. Save the file as a GIF animation.
1. Create a PNG from the GIF showing just frame 0 as file-closed.png.

## 2023-11-12 - Updating this Wiki

We are using images in the project's documents/images director  for this Wiki. To insert an image in the Wiki we add a line like the following:

```[[https://github.com/CoghillClanCoding/Shoot-My-Challengers/blob/wiki/documentation/images/bomb.png]]```

[[https://github.com/CoghillClanCoding/Shoot-My-Challengers/blob/wiki/documentation/images/bomb.png]]

Because we use the `documents/images` directory only for this Wiki we created a special branch named 'wiki'. Any time you want to
add an image to this Wiki you must first switch to the 'wiki' branch before committing and pushing to this repository.

The 'wiki' branch is used only for changes regarding this Wiki.

