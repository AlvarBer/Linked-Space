extends Sprite


signal chest_opened

func _ready():
	pass

func on_body_entered(body):
	self.frame = 1
	self.emit_signal("chest_opened")