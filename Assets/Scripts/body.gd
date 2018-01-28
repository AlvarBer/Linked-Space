extends StaticBody2D

export(String) var world
export(String) var other
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)
onready var other_raycast = linked.get_node("../Player/KinematicBody2D/RayCast2D")

func _ready():
	self.set_meta("Movable", true)

func on_taken():
	linked.modulate = Color("9659598c")
	linked.get_node("CollisionShape2D").disabled = true

func on_place():
	linked.modulate = Color("ffffff")
	linked.position = self.position
	linked.get_node("CollisionShape2D").disabled = false

func on_body_enter(body):
	if body is KinematicBody2D:
		body.get_parent().on_take_available(self)

func on_body_exited(body):
	if body is KinematicBody2D:
		body.get_parent().on_take_unavailable()

func test():
	self.linked.position = self.position