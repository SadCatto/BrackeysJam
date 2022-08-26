extends KinematicBody2D

export var DAGGER: PackedScene = preload("res://Scenes/Dagger.tscn")

onready var attackTimer = $AttackTimer

var health = 100

func _physics_process(delta: float) -> void:
	if  attackTimer.is_stopped():
		var random = Vector2(rand_range(0,1000),rand_range(0,1000))
		var dagger_rotation = self.global_position.direction_to(random).angle()
		throw_dagger(dagger_rotation)

func throw_dagger(dagger_rotation):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		dagger.rotation = dagger_rotation
		attackTimer.start()

func take_damage(damage):
	health = health - damage
