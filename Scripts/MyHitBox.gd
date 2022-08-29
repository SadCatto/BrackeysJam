class_name MyHitBox
extends Area2D

export var damage = 15

func _init():
	collision_layer = 2
	collision_mask = 0
