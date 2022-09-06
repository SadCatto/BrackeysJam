extends KinematicBody2D

export var DAGGER: PackedScene = preload("res://Scenes/Dagger.tscn")

onready var attackTimer = $AttackTimer

var playerNode = null
var detect_radius = 300
var vis_color = Color(.867, .91, .247, 0.1)

var health = 100

func _ready():
	var detectCircle = CircleShape2D.new()
	detectCircle.radius = detect_radius
	$playerDetection/CollisionShape2D.shape = detectCircle
	
func _physics_process(delta: float) -> void:
	if playerNode:
		rotation = self.global_position.direction_to(playerNode.position).angle()
		if  attackTimer.is_stopped():
			var random = Vector2(rand_range(0,1000),rand_range(0,1000))
			var dagger_rotation = self.global_position.direction_to(playerNode.position).angle()
			throw_dagger(dagger_rotation)

func throw_dagger(dagger_rotation):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		dagger.rotation = dagger_rotation
		print("deg")
		attackTimer.start()

func take_damage(damage):
	health = health - damage

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)

func _on_playerDetection_body_entered(body):
	if body.is_in_group("player"):
		vis_color = Color(1, 0, 0, 0.1)
		update()
		playerNode = body


func _on_playerDetection_body_exited(body):
	if body.is_in_group("player"):
		vis_color = Color(.867, .91, .247, 0.1)
		update()
		playerNode = null
