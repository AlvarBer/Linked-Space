extends StaticBody2D

const Util = preload("res://Assets/Scripts/Util.gd")
export(String) var world
export(String) var other


onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)

func _ready():
	self.set_process(false)

func _process(delta):
	self.on_continued_act(false)

func on_act(active, player):
	# Assume acting is possible
	$CollisionShape2D.disabled = true
	if active:
		Util.reparent(self, player)
		self.position = Vector2(0, 0)
	else:
		Util.reparent(self.get_node("../Player/KinematicBody2D/RayCast2D"), self)
		$RayCast2D.position = Vector2(0, 0)
		self.modulate = Color("#434343")
		self.set_process(true)

func on_continued_act(active):
	if not active:
		self.position = Util.pos_relative_to(self.linked, self.linked.get_node("../.."))

func on_stop_act(active, player):
	if active:
		var pos_on_map = Util.pos_relative_to(self, self.get_node("../.."))
		Util.reparent(self, self.get_node("../.."))
		self.position = pos_on_map
	else:
		self.modulate = Color("#ffffff")
		self.set_process(false)
		Util.reparent($RayCast2D, self.get_node("../Player/KinematicBody2D"))
	self.position += player.last_move * 48
	$CollisionShape2D.disabled = false

func can_stop_act(active, player):
	var raycast
	if active:
		raycast = player.get_node("KinematicBody2D/RayCast2D")
	else:
		raycast = $RayCast2D
	raycast.position = player.last_move * 25
	raycast.cast_to = player.last_move * 35
	raycast.add_exception(self)
	raycast.force_raycast_update()
	raycast.remove_exception(self)
	return not raycast.is_colliding()

func on_body_enter(body):
	if body is KinematicBody2D:
		body.get_parent().on_take_available(self)

func on_body_exited(body):
	if body is KinematicBody2D:
		body.get_parent().on_take_unavailable()