extends Node2D

export var player_idx = 1
export var speed = 100
export(Texture) var texture
var holding_obj
var last_move = Vector2(0, 0)
onready var anim_player = $AnimationPlayer
var anim = ""

func _ready():
	$KinematicBody2D/Sprite.set_texture(texture)
	set_process(true)

func _process(delta):
	var movement = Vector2(0, 0)
	var result = null
	var new_anim = "idle"
	
	if Input.is_action_pressed("player_%d_left" % player_idx):
		movement += Vector2(-1, 0)
		new_anim = "walk_left"
	elif Input.is_action_pressed("player_%d_right" % player_idx):
		movement += Vector2(1, 0)
		new_anim = "walk_right"
	elif Input.is_action_pressed("player_%d_up" % player_idx):
		movement += Vector2(0, -1)
		new_anim = "walk_up"
	elif Input.is_action_pressed("player_%d_down" % player_idx):
		movement += Vector2(0, 1)
		new_anim = "walk_down"
	
	if movement != Vector2(0, 0):
		result = $KinematicBody2D.move_and_collide(movement * speed * delta)
		if not result:
			last_move = movement
	
	if Input.is_action_just_pressed("player_%d_take" % player_idx):
		print("Pressing move")
		if holding_obj:
			holding_obj.position += last_move * 64
			var pos_to_set = holding_obj.get_relative_transform_to_parent(self.get_parent()).origin
			$KinematicBody2D.remove_child(holding_obj)
			self.get_parent().add_child(holding_obj)
			holding_obj.position = pos_to_set
			holding_obj.get_node("CollisionShape2D").disabled = false
			holding_obj.on_place()
			holding_obj = null
		elif result and result.collider.has_meta("Movable"):
			holding_obj = result.collider
			holding_obj.get_node("CollisionShape2D").disabled = true
			holding_obj.get_parent().remove_child(holding_obj)
			$KinematicBody2D.add_child(holding_obj)
			holding_obj.position = Vector2(0, 0)
			holding_obj.on_taken()

	if new_anim != anim:
		anim = new_anim
		anim_player.play(anim)