extends StaticBody2D


const Util = preload("res://Assets/Scripts/Util.gd")
export(String) var group
var linked

func _enter_tree():
	if self.group:
		self.add_to_group(self.group)

func _ready():
	self.set_process(false)
	if self.group:
		for node in self.get_tree().get_nodes_in_group(self.group):
			if node != self:
				self.linked = node

func _process(delta):
	self.on_continued_act(false)


func on_body_enter(body):
	pass

func on_body_exited(body):
	pass

func on_act(active, player):
	if not active:
		$CollisionShape2D.disabled = true
		Util.reparent(self.get_node("../Player/RayCast2D"), self)
		$RayCast2D.position = Vector2(0, 0)
		self.modulate = Color("#434343")
		self.set_process(true)

func on_continued_act(active):
	if not active and self.is_processing():  # To avoid race conditions
		self.position = Util.pos_on_paren(self.linked.get_parent())

func can_stop_act(active, player):
	var raycast = $RayCast2D
	raycast.position = player.last_move * 25
	raycast.cast_to = player.last_move * 35
	raycast.add_exception(self)
	raycast.force_raycast_update()
	raycast.remove_exception(self)
	return not raycast.is_colliding()

func on_stop_act(active, player):
	if not active:
		self.set_process(false)
		self.modulate = Color("#ffffff")
		Util.reparent($RayCast2D, self.get_node("../Player"))
		self.position += player.last_move * 48
		$CollisionShape2D.disabled = false
