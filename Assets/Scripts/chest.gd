extends Sprite

signal chest_opened

func _ready():
	pass

func on_body_entered(body):
	frame = 1
	emit_signal("chest_opened")