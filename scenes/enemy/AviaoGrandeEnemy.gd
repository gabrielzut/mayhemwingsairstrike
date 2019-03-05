extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export var shootInterval = 1.0
export var pausado = true
export var scrollDown = 0

func start():
	visible = true
	pausado = false
	scrollDown = 0
	$Path2D/PathFollow2D/AviaoGEnemy.collision_layer = 4
	$Path2D/PathFollow2D/AviaoGEnemy.collision_mask = 10

func _ready():
	if pausado:
		$Path2D/PathFollow2D/AviaoGEnemy.collision_layer = 0
		$Path2D/PathFollow2D/AviaoGEnemy.collision_mask = 0
		visible = false
	else:
		start()

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if pausado == false:
		$Path2D/PathFollow2D.offset = $Path2D/PathFollow2D.offset + 80 * delta

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen() and pausado == false:
		var shoot = weapon.instance()
		shoot.position = $Position2D.get_global_position()
		shoot.rotation_degrees = global_rotation_degrees
		get_tree().get_root().get_child(1).add_child(shoot)

func damage(dmg):
	hp -= dmg
	$Path2D/PathFollow2D/AviaoGEnemy/AnimationPlayer.play("damage")

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.scale = Vector2(4,4)
		explosion.position = $Path2D/PathFollow2D/AviaoGEnemy.global_position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()