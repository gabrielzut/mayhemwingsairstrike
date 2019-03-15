extends ColorRect

signal animation(source)
var source = ""

func fadein(sourceM):
	$AnimationPlayer.play("fadein")
	source = sourceM
	
func fadeout(sourceM):
	$AnimationPlayer.play("fadeout")
	source = sourceM

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("animation",source)