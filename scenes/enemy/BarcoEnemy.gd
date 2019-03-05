extends "res://classes/destructable.gd"

export var maxVelocidade = 30
export var scrollDown = 20
var velocidade = Vector2(0,0)
export var tempoMov = 30
export var pausado = true

func start():
	visible = true
	pausado = false
	collision_layer = 1
	collision_mask = 0
	velocidade = Vector2(0,maxVelocidade).rotated(rotation)
	$AnimatedSprite/Explosion.connect("exploded", self, "_explosion_exploded")
	for child in get_children():
		if child.has_method("start"):
			child.start()
	$Timer.wait_time = tempoMov
	$Timer.one_shot = true
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
	
	if $CanhaoEnemy1.destroyed == true:
		if has_node("CanhaoEnemy2"):
			if $CanhaoEnemy2.destroyed == true:
				collision_mask = 8
		else:
			collision_mask = 8
	
func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func damage(dmg):
	hp -= dmg
	$".".get_node("AnimationPlayer").play("damage")
	
	if hp <= 0:
		$Collision.disabled = true
		
		for child in $AnimatedSprite.get_children():
			if child.has_method("explode"):
				child.explode()
				
		$AnimationPlayer.play("explode")
		
		singletons.addScore(score)

func _explosion_exploded(confirmation):
	if(confirmation):
		queue_free()

func _on_Timer_timeout():
	velocidade = Vector2(0,0)
