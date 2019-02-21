extends ParallaxBackground

export var offPos = 0

func _process(delta):
	offPos = offPos + 20 * delta
	scroll_offset = Vector2(0,offPos)
