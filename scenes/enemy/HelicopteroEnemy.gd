extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot2.tscn")
export var shootInterval = 1.0
export var shootSpeed = 0
export var pausado = true
export var scrollDown = 20
var ended = false

func start():
	visible = true
	pausado = false
	scrollDown = 0
	$GlobalTimer.start()
	$Path2D/PathFollow2D/HeliEnemy/Timer.wait_time = shootInterval
	$Path2D/PathFollow2D/HeliEnemy.collision_layer = 4
	$Path2D/PathFollow2D/HeliEnemy.collision_mask = 10
	$Path2D/PathFollow2D/AnimationPlayer.play("StartPath1")

func _ready():
	if pausado:
		$Path2D/PathFollow2D/HeliEnemy.collision_layer = 0
		$Path2D/PathFollow2D/HeliEnemy.collision_mask = 0
		visible = false
	else:
		start()

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if pausado == false:
		if $Path2D/PathFollow2D/HeliEnemy/Timer.is_stopped():
			$Path2D/PathFollow2D/HeliEnemy/Timer.start()

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado and ended:
		queue_free()

func _on_Timer_timeout():
	if $Path2D/PathFollow2D/HeliEnemy/VisibilityNotifier2D.is_on_screen() and pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Path2D/PathFollow2D/HeliEnemy/Position2D.get_global_position()
		var pos = Vector2(0,0)
		if get_tree().get_root().get_child(1).has_node("Player"):
			pos = get_tree().get_root().get_child(1).get_node("Player").position
		shoot.look_at(pos)
		get_tree().get_root().get_child(1).add_child(shoot)

func _on_GlobalTimer_timeout():
	$Path2D/PathFollow2D/AnimationPlayer.play("EndPath1")
	ended = true

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.global_position = $Path2D/PathFollow2D/HeliEnemy.global_position
			get_tree().get_root().get_child(1).add_child(powerupDrop)
		explosion.position = $Path2D/PathFollow2D/HeliEnemy.global_position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()