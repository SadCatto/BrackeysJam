extends KinematicBody2D

export var speed = 350.0

var velocity := Vector2.ZERO
var extraVel := Vector2.ZERO
var knockback = Vector2.ZERO

var health = 3
onready var healthGui = $Gui

const scent_scene = preload("res://scenes/ScentScene.tscn")
var scent_trail = []

func _ready() -> void:
	#add scent scenes to the scent_trail array
	$ScentTimer.connect("timeout", self, "add_scent")

func _input(event):
	#For zooming out and zooming in the camera
	if event.is_action_pressed('scroll_up'):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
	if event.is_action_pressed('scroll_down'):
		$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1, 0.1)

func _physics_process(delta: float) -> void:

	var horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	var vertical_direction = (
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	velocity.x =  horizontal_direction * speed
	velocity.y = vertical_direction * speed
	
	
	velocity = move_and_slide(velocity + knockback)
	knockback = lerp(knockback, Vector2.ZERO, 0.4)

	"""lerp sometimes sometimes sets velocity to infinity so to clip it back to zero
	we check if it is close to zero, if it is we set it to zero"""
	if(is_zero_approx(velocity.x) && is_zero_approx(velocity.y)):
		velocity = Vector2.ZERO
		
	
	#flipping the sprites to face the correct direction
	if(velocity.x<0):
		$playerSprite.flip_h = true
	elif(velocity.x>0):
		$playerSprite.flip_h = false
		
		
	#setting the animations
	if(velocity!=Vector2.ZERO):
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
	
	#checking death
	if health <= 0:
		get_tree().change_scene("res://Scenes/end.tscn")
		get_tree().call_group("levelChange", "levelChange")
		queue_free()
		

#Enemy follows these scent scenes rather than the player
func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = position
	get_tree().get_root().add_child(scent)
	scent_trail.push_back(scent)

func take_damage():
	health -=1
	healthGui.get_child(health).queue_free()


#to add knockback after damage
func knockBack(enemypos: Vector2):
	var diff = enemypos.direction_to(self.global_position)
	knockback = diff.normalized() * 2000

	
	
#for bullet and enemy detection
func _on_enemyDetection_body_entered(body):
	if body.is_in_group('enemy'):
		take_damage()
		knockBack(body.position)


func _on_enemyDetection_area_entered(area):
	if area.is_in_group('bullet'):
		take_damage()
		knockBack(area.position)
