extends ParallaxBackground

export var pausado = false
export var offPos = 0

func _process(delta):
	if pausado == false:
		offPos = offPos + 20 * delta
		scroll_offset = Vector2(0,offPos)
