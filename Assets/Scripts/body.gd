extends StaticBody2D

export(String) var world
export(String) var other
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)
onready var other_raycast = linked.get_node("../Player/KinematicBody2D/RayCast2D")

func _ready():
	self.set_meta("Movable", true)

func check_other_world(holding_obj_pos, destination):
	other_raycast.position = holding_obj_pos
	other_raycast.cast_to = destination
	other_raycast.force_raycast_update()
	other_raycast.add_exception(linked)
	var colliding = other_raycast.is_colliding()
	other_raycast.remove_exception(linked)
	other_raycast.position = Vector2(0, 0)
	return colliding

func on_taken():
	linked.modulate = Color("434343")
	linked.get_node("CollisionShape2D").disabled = true

func on_place():
	linked.modulate = Color("ffffff")
	linked.position = self.position
	linked.get_node("CollisionShape2D").disabled = false

func get_other_raycast():
	return self.other_raycast
