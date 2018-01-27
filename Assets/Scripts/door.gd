extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func unlock():
	frame = 1
	$StaticBody2D/CollisionShape2D.disabled = true
	
func lock():
	frame = 0
	$StaticBody2D/CollisionShape2D.disabled = false
	
