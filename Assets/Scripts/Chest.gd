extends Sprite


func _ready():
	pass


func _on_Area2D_body_entered(body):
	frame = 1
	self.get_node("../../../../../..").add_opened()
