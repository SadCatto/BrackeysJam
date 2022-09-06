extends Node2D

export var DAGGER: PackedScene = preload("res://Scenes/Dagger.tscn")

signal state_changed(new_state)

enum State {
	IDLE,
	ENGAGE
}

onready var attackTimer = $attackTimer
onready var player_detection_zone = $PlayerDetectopn

var current_state = State.IDLE setget set_state
var Player = null

func set_state(new_state):
	if new_state == current_state:
		return
		
	current_state = new_state
	emit_signal("state_changed",current_state)

func _process(delta: float) -> void:
	match current_state:
		State.IDLE:
			pass
		State.ENGAGE:
			if Player!= null and attackTimer.is_stopped():
				var dagger_rotation = self.global_position.direction_to(Player.global_position).angle()
				throw_dagger(dagger_rotation)
		_:
			print("Error")

func throw_dagger(dagger_rotation):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		dagger.rotation = dagger_rotation
		attackTimer.start()


func _on_PlayerDetectopn_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		Player = body
		


func _on_PlayerDetectopn_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(State.IDLE)
		Player = null


func _on_CloseCombat_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_detection_zone.monitoring = false


func _on_CloseCombat_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_detection_zone.monitoring = true
