extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot1.tscn")
export var destroyed = false
export var scrollDown = 20.2

func _process(delta):
	if get_tree().get_root().get_child(1).get_node("Player") and destroyed == false:
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
	move_and_slide(Vector2(0,scrollDown))
	
func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen() and destroyed == false:
		var shoot = weapon.instance()
		shoot.position = $Position2D.get_global_position()
		shoot.rotation_degrees = rotation_degrees + 90
		get_tree().get_root().get_child(1).add_child(shoot)
		
func damage(dmg):
	hp -= dmg

	if hp <= 0 and destroyed == false:
		singletons.addScore(score)
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		destroyed = true
		rotation_degrees = -90
		$Timer.stop()
		$CollisionShape2D.disabled = true
		firedestroyed.rotation_degrees = 90
		firedestroyed.position = $AnimatedSprite.position
		add_child(firedestroyed)
		$AnimatedSprite.hide()