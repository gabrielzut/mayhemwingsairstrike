extends Control

onready var singletons = get_node("/root/Singletons")

func _ready():
	if singletons.muted == true:
		$"Botões/Sound".pressed = false

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/stages/TitleScreen.tscn")

func _on_Sound_toggled(button_pressed):
	singletons.mute()

func _on_Menu_focus_entered():
	$PlayerFocus.play()

func _on_Sound_mouse_entered():
	$"Botões/Sound".grab_focus()

func _on_Return_mouse_entered():
	$"Botões/Return".grab_focus()
