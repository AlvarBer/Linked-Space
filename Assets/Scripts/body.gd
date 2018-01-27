extends StaticBody2D

export(String) var world
export(String) var other
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)
onready var other_raycast = linked.get_node("../Player/KinematicBody2D/RayCast2D")

func _ready():
	self.set_meta("Movable", true)

func on_taken():
	linked.modulate = Color("434343")
	linked.get_node("CollisionShape2D").disabled = true

func on_place():
	linked.modulate = Color("ffffff")
	linked.position = self.position
	linked.get_node("CollisionShape2D").disabled = false
