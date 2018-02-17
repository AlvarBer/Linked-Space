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
	$CollisionShape2D.disabled = true
	Util.reparent(self.get_node("../Player/RayCast2D"), self)
	if active:
		Util.reparent(self, player)
		self.position = Vector2(0, 0)
	else:
		$RayCast2D.position = Vector2(0, 0)
		self.modulate = Color("#434343")
		self.set_process(true)

func on_continued_act(active):
	if not active and self.is_processing():
		self.position = Util.pos_on_paren(self.linked.get_parent())

func on_stop_act(active, player):
	if active:
		var pos_on_map = Util.pos_on_paren(self.get_parent())
		Util.reparent(self, self.get_node("../.."))
		self.position = pos_on_map
	else:
		self.set_process(false)
		self.modulate = Color("#ffffff")
	Util.reparent($RayCast2D, self.get_node("../Player"))
	self.position += player.last_move * 48
	$CollisionShape2D.disabled = false

func can_stop_act(active, player):
	var raycast = $RayCast2D
	raycast.position = player.last_move * 25
	raycast.cast_to = player.last_move * 35
	raycast.add_exception(self)
	raycast.force_raycast_update()
	raycast.remove_exception(self)
	return not raycast.is_colliding()

func on_body_enter(body):
	if body is KinematicBody2D:
		body.on_take_available(self)

func on_body_exit(body):
	if body is KinematicBody2D:
		body.on_take_unavailable()
