extends Node2D

export var player_idx = 1
export var speed = 100

func _ready():
	set_process(true)

func _process(delta):
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed("player_%d_left" % player_idx):
		movement += Vector2(-1, 0)
	if Input.is_action_pressed("player_%d_right" % player_idx):
		movement += Vector2(1, 0)
	if Input.is_action_pressed("player_%d_up" % player_idx):
		movement += Vector2(0, -1)
	if Input.is_action_pressed("player_%d_down" % player_idx):
		movement += Vector2(0, 1)
		
	position += movement * speed * delta
