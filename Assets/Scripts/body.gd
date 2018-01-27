extends StaticBody2D

export(String) var path
onready var linked = get_node(path)


func _ready():
	self.set_meta("Movable", true)

func on_taken():
	linked.modulate = Color("434343")
	linked.get_node("CollisionShape2D").disabled = true

func on_place():
	linked.modulate = Color("ffffff")
	linked.position = self.position
	linked.get_node("CollisionShape2D").disabled = false
	#linked.visible = true