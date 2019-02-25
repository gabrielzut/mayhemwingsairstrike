extends Node

var playerSprite = preload("res://graphics/plane/aviao1.png")
var playerWeapon = preload("res://scenes/props/WLaser.tscn")
var explosion = preload("res://scenes/particles/explosion.tscn")
var playerPowerup = 1
var playerLife = 3
var playerBomb = 2
var playerScore = 0

func addPower(var power):
	if playerPowerup + power <= 3:
		playerPowerup += power
	else:
		playerPowerup = 3
		addScore(100)
		
func addLife(var life):
	playerLife += life
	
func addBomb(var bomb):
	if playerBomb + bomb <= 3:
		playerBomb += bomb
	else:
		playerBomb = 3
		addScore(100)

func addScore(var score):
	playerScore += score

var gameStatus = 2 #0 - fora do jogo/1 - pausado/2 - em jogo

# Para adicionar o singleton nos códigos usar
# onready var singletons = get_node("/root/Singletons")