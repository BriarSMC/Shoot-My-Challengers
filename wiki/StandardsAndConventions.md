This describes the standards and conventions used by SMC.

# Godot Editor

## Name Case

* _File Names_: snake case
* _Class Names_: Pascal case
* _Function Names_: Camel case
* _Variable Names_: Camel case
* _Constants_: CAPITALS
* _Directory Names_: 
  - Containing Godot elements: Pascal case
  - All others: snake case
* _Animation Track Names_: Pascal Case

Class, function and variable names should avoid using underscore (\_) and hyphen(\-). Other names can include these.

Exceptions:

* File Names: Files imported from outside sources. (E. G. Graphics)

# Templates

Template files are kept in Godot's `res://templates`.

These include:
* _class_header.gd_: Use to define a class
* _method_header.gd_: Use to define methods in a script
