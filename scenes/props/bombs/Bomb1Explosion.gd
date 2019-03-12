extends Area2D

var dmg = 10
var damage_time = 0.3
var duration_ticks = 7

func _ready():
	$Timer.wait_time = damage_time
	$Timer.start()
	$AnimationPlayer.play("explode")

func _on_Timer_timeout():
	if duration_ticks <= 0:
		queue_free()
	else:
		for body in get_overlapping_bodies():
			if body.has_method("damage"):
				if !("Player" in body.name):
					body.damage(dmg)
			else:
				for child in body.get_children():
					if child.has_method("damage"):
						if !("Player" in child.name):
							child.damage(dmg)
	duration_ticks -= 1