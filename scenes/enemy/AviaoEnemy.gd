extends "res://classes/destructable.gd"

enum ShootType{
	NONE,STRAIGHT,FOLLOW
}

export var maxVelocidade = 150
export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export(ShootType) var shootType = 0
export var shootInterval = 1.0
export var shootSpeed = 0
export var pausado = true
export var scrollDown = 0

var velocidade = Vector2(0,0)

func start():
	visible = true
	pausado = false
	
	collision_layer = 4
	collision_mask = 10
	velocidade = Vector2(0,-maxVelocidade).rotated(get_global_transform().get_rotation())
	
	if shootType != ShootType.NONE:
		$Timer.wait_time = shootInterval
		$Timer.start()

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

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen() and pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Position2D.get_global_position()
		if shootType == ShootType.STRAIGHT:
			shoot.rotation_degrees = global_rotation_degrees
		elif shootType == ShootType.FOLLOW:
			if get_tree().get_root().get_child(1).has_node("Player"):
				var pos = get_tree().get_root().get_child(1).get_node("Player").position
				shoot.look_at(pos)
				shoot.global_rotation_degrees += 90
		get_tree().get_root().get_child(1).add_child(shoot)
