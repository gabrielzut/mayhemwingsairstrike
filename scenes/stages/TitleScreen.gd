extends Control

var fade = false
var som = false

func _ready():
	$Fade.fadein("self")
	som = false
	$"Botões/NovoJogo".grab_focus()
	som = true

func _on_Quit_pressed():
	$PlayerSelection.play()
	get_tree().quit()

func _on_NovoJogo_pressed():
	playSelection()
	$Fade.fadeout("ng")
	fade = true
	yield()
	get_tree().change_scene("res://scenes/stages/stage1.tscn")

func _on_Fade_animation(source):
	if source == "ng":
		var novoJogoFunc = _on_NovoJogo_pressed()
		novoJogoFunc.resume()

func _on_MenuButton_focus_entered():
	if som == true:
		$PlayerFocus.play()

func _on_NovoJogo_mouse_entered():
	$"Botões/NovoJogo".grab_focus()

func _on_Highscores_mouse_entered():
	$"Botões/Highscores".grab_focus()

func _on_Options_mouse_entered():
	$"Botões/Options".grab_focus()

func _on_Quit_mouse_entered():
	$"Botões/Quit".grab_focus()
	
func playSelection():
	if som == true:
		$PlayerSelection.play()
		som = false

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/stages/MenuOptions.tscn")
