extends "res://classes/destructable.gd"

export var maxVelocidade = 30
var velocidade = Vector2(0,0)

func _ready():
		velocidade = Vector2(0,maxVelocidade).rotated(rotation)
		$AnimatedSprite/Explosion.connect("exploded", self, "_explosion_exploded")

func _physics_process(delta):
	var colisao = move_and_collide(velocidade * delta)
	
	if $CanhaoEnemy1.destroyed == true and $CanhaoEnemy2.destroyed == true:
		collision_mask = 8
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func damage(dmg):
	hp -= dmg
	$".".get_node("AnimationPlayer").play("damage")
	
	if hp <= 0:
		$AnimatedSprite/Explosion.explode()
		$AnimatedSprite/Explosion2.explode()
		$AnimatedSprite/Explosion3.explode()
		$AnimatedSprite/Explosion4.explode()
		$AnimationPlayer.play("explode")
		
		singletons.addScore(score)

func _explosion_exploded(confirmation):
	if(confirmation):
		queue_free()