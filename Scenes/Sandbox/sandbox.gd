extends Node2D

enum en {a,b,c,d}
var a: Array = [en.a, en.b, en.c, en.d,]

func _ready():
	print(a)
