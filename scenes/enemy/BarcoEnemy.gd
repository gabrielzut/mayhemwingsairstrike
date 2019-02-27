extends "res://classes/destructable.gd"

export var maxVelocidade = 30
export var scrollDown = 20.2
var velocidade = Vector2(0,0)
export var pausado = true

func start():
	visible = true
	pausado = false
	collision_layer = 1
	collision_mask = 0
	velocidade = Vector2(0,maxVelocidade).rotated(rotation)
	$AnimatedSprite/Explosion.connect("exploded", self, "_explosion_exploded")
	$CanhaoEnemy1.start()
	$CanhaoEnemy2.start()

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
	
	if $CanhaoEnemy1.destroyed == true and $CanhaoEnemy2.destroyed == true:
		collision_mask = 8
	
func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func damage(dmg):
	hp -= dmg
	$".".get_node("AnimationPlayer").play("damage")
	
	if hp <= 0:
		$CollisionPolygon2D.disabled = true
		$AnimatedSprite/Explosion.explode()
		$AnimatedSprite/Explosion2.explode()
		$AnimatedSprite/Explosion3.explode()
		$AnimatedSprite/Explosion4.explode()
		$AnimationPlayer.play("explode")
		
		singletons.addScore(score)

func _explosion_exploded(confirmation):
	if(confirmation):
		queue_free()