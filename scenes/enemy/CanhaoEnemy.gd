extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot1.tscn")
var destroyed = false

func _process(delta):
	if get_parent().get_node("Player") and destroyed == false:
		var pos = get_parent().get_node("Player").position
		look_at(pos)
	move_and_slide(Vector2(0,20.2))
	
func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen() and destroyed == false:
		var shoot = weapon.instance()
		shoot.position = $Position2D.get_global_position()
		shoot.rotation_degrees = rotation_degrees + 90
		get_parent().add_child(shoot)
		
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