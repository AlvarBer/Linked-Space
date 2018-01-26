extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_pressed("player_1_left"):
		position.x -= 100 * delta
	if Input.is_action_pressed("player_1_right"):
		position.x += 100 * delta
	if Input.is_action_pressed("player_1_up"):
		position.y -= 100 * delta
	if Input.is_action_pressed("player_1_down"):
		position.y += 100 * delta
