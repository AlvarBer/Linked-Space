extends KinematicBody2D

const Util = preload("res://Assets/Scripts/Util.gd")
export var player_idx = 1
export var speed = 100
export(Texture) var texture


var holding_obj
var last_move = Vector2(0, 0)
var anim = ""
var available_object
onready var anim_player = $AnimationPlayer

func _ready():
	$Sprite.set_texture(texture)
	set_process(true)

func _process(delta):
	var movement = Vector2(0, 0)
	var result = null
	var new_anim = ""

	# Check inputs
	if Input.is_action_pressed("player_%d_left" % player_idx):
		movement += Vector2(-1, 0)
		new_anim = "walk_left"
	elif Input.is_action_pressed("player_%d_right" % player_idx):
		movement += Vector2(1, 0)
		new_anim = "walk_right"
	elif Input.is_action_pressed("player_%d_up" % player_idx):
		movement += Vector2(0, -1)
		new_anim = "walk_top"
	elif Input.is_action_pressed("player_%d_down" % player_idx):
		movement += Vector2(0, 1)
		new_anim = "walk_bot"

	if movement != Vector2(0, 0): # Do actual movement
		result = self.move_and_collide(movement * speed * delta)
		if not result:
			last_move = movement

	if new_anim == "":
		if last_move == Vector2(1, 0):
			new_anim = "idle_right"
		elif last_move == Vector2(-1, 0):
			new_anim = "idle_left"
		elif last_move == Vector2(0, 1):
			new_anim = "idle_bot"
		elif last_move == Vector2(0, -1):
			new_anim = "idle_top"
		else:
			new_anim = "idle_right"
	if new_anim != anim:
		anim = new_anim
		anim_player.play(anim)

	# Taking/placing things
	if Input.is_action_just_pressed("player_%d_take" % player_idx):
		if holding_obj:  # Trying to place
			if Util.can_stop_act(self.holding_obj, self):
				Util.stop_act(self.holding_obj, self)
				holding_obj = null
			else:
				$SpriteForbidden.visible = true
				$Timer.start()
		elif available_object:  # Trying to take
			self.holding_obj = available_object
			Util.act(available_object, self)

func on_take_available(obj):
	self.available_object = obj
	$SpriteAllowed.visible = true

func on_take_unavailable():
	self.available_object = null
	$SpriteAllowed.visible = false

func on_timer_timeout():
	$SpriteForbidden.visible = false
