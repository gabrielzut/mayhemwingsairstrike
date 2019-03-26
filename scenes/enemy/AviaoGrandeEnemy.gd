extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export var shootInterval = 1.0
export var shootSpeed = 0
export var pausado = true
export var scrollDown = 0

func start():
	visible = true
	pausado = false
	scrollDown = 0
	$Path2D/PathFollow2D/AviaoGEnemy/Timer.wait_time = shootInterval
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
		
		if $Timer.is_stopped():
			$Timer.start()

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func _on_Timer_timeout():
	if $Path2D/PathFollow2D/AviaoGEnemy/VisibilityNotifier2D.is_on_screen() and pausado == false:
		var shoot1 = weapon.instance()
		var shoot2 = weapon.instance()
		var shoot3 = weapon.instance()
		shoot1.seguir = false
		shoot2.seguir = false
		shoot3.seguir = false
		
		if shootSpeed > 0:
			shoot1.maxVelocidade = shootSpeed
			shoot2.maxVelocidade = shootSpeed
			shoot3.maxVelocidade = shootSpeed
		
		shoot1.position = $Path2D/PathFollow2D/AviaoGEnemy/Position2D.get_global_position()
		shoot2.position = $Path2D/PathFollow2D/AviaoGEnemy/Position2D.get_global_position()
		shoot3.position = $Path2D/PathFollow2D/AviaoGEnemy/Position2D.get_global_position()
		var pos = Vector2(0,0)
		if get_tree().get_root().get_child(1).has_node("Player"):
			pos = get_tree().get_root().get_child(1).get_node("Player").position
		shoot1.look_at(pos)
		shoot2.look_at(pos)
		shoot3.look_at(pos)
		shoot1.global_rotation_degrees += 90
		shoot2.global_rotation_degrees += 75
		shoot3.global_rotation_degrees += 105
		get_tree().get_root().get_child(1).add_child(shoot1)
		get_tree().get_root().get_child(1).add_child(shoot2)
		get_tree().get_root().get_child(1).add_child(shoot3)

func damage(dmg):
	hp -= dmg
	$Path2D/PathFollow2D/AviaoGEnemy/AnimationPlayer.stop()
	$Path2D/PathFollow2D/AviaoGEnemy/AnimationPlayer.play("damage")
	$Path2D/PathFollow2D/AviaoGEnemy/PlayerHit.play()

	if hp <= 0:
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.global_position = $Path2D/PathFollow2D/AviaoGEnemy.global_position
			get_tree().get_root().get_child(1).add_child(powerupDrop)
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.scale = Vector2(4,4)
		explosion.position = $Path2D/PathFollow2D/AviaoGEnemy.global_position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()

func _on_Global_Timer_timeout():
	scrollDown = -50
