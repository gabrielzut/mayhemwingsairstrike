extends Control

var fade = false

func _ready():
	$Fade.fadein("self")

func _on_Quit_pressed():
	get_tree().quit()

func _on_NovoJogo_pressed():
	$Fade.fadeout("ng")
	fade = true
	yield()
	get_tree().change_scene("res://scenes/stages/stage1.tscn")

func _on_Fade_animation(source):
	if source == "ng":
		var novoJogoFunc = _on_NovoJogo_pressed()
		novoJogoFunc.resume()