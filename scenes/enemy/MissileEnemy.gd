extends "res://classes/destructable.gd"

export var maxVelocidade = 150
export var pausado = true
export var scrollDown = 0

var velocidade = Vector2(0,0)

func start():
	visible = true
	pausado = false
	
	collision_layer = 4
	collision_mask = 2
	velocidade = Vector2(0,-maxVelocidade).rotated(get_global_transform().get_rotation())

func _ready():
	if pausado:
		collision_layer = 0
		collision_mask = 0
		visible = false
	else:
		start()

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao != null and 'Player' in colisao.collider.name:
		damage(1)
		colisao.collider.damage(1)

func damage(dmg):
	hp -= dmg
	$AnimationPlayer.stop()
	$AnimationPlayer.play("damage")
	$PlayerHit.play()

	if hp <= 0:
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.global_position = global_position
			get_tree().get_root().get_child(1).add_child(powerupDrop)
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = global_position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()
