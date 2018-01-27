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
	
	# Check inputs
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
	
	# Do actual movement
	if movement != Vector2(0, 0):
		result = $KinematicBody2D.move_and_collide(movement * speed * delta)
		if not result:
			last_move = movement

	if new_anim != anim:
		anim = new_anim
		anim_player.play(anim)

	# Taking/placing things
	if Input.is_action_just_pressed("player_%d_take" % player_idx):
		if holding_obj:  # Trying to place
			var this_world_raycast = $KinematicBody2D/RayCast2D
			var other_world_raycast = holding_obj.other_raycast
			for raycast in ([this_world_raycast, other_world_raycast]):
				raycast.position = Vector2(0, 0)
			other_world_raycast.position = other_world_position(holding_obj)
			for raycast_n_obj in ([
			    [this_world_raycast, holding_obj],
				[other_world_raycast, holding_obj.linked]
			]):
				var raycast = raycast_n_obj[0]
				var obj = raycast_n_obj[1]
				raycast.position += last_move * 25
				raycast.cast_to = last_move * 80
				raycast.add_exception(obj)
				raycast.force_raycast_update()
				raycast.remove_exception(obj)
			if (not this_world_raycast.is_colliding() and
			    not other_world_raycast.is_colliding()):
				
				holding_obj.position = other_world_position(holding_obj)
				for obj in [holding_obj, holding_obj.linked]:
					obj.position += last_move * 64
					obj.get_node("CollisionShape2D").disabled = false
				reparent(holding_obj, self.get_parent())
				holding_obj.on_place()
				holding_obj = null
			else:
				$KinematicBody2D/forbidden.visible = true
				$Timer.start()
		elif result and result.collider.has_meta("Movable"):  # Trying to take
			holding_obj = result.collider
			holding_obj.get_node("CollisionShape2D").disabled = true
			reparent(holding_obj, $KinematicBody2D)
			holding_obj.position = Vector2(0, 0)
			holding_obj.on_taken()
			$KinematicBody2D/RayCast2D.add_exception(holding_obj)


static func reparent(node, new_parent):
	""" Changes the parent of node to new_parent """
	node.get_parent().remove_child(node)
	new_parent.add_child(node)

func other_world_position(node):
	return node.get_relative_transform_to_parent(self.get_parent()).origin

func on_Timer_timeout():
	$KinematicBody2D/forbidden.visible = false
