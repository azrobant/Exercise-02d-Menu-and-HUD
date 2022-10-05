extends Node

var VP = null

var score = 0
var time = 0
var lives = 0


func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed",self,"_resize")
	reset()

func _physics_process(_delta):
	var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count() == 0:
			var _scene = get_tree().change_scene("res://UI/End_Game.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var pause_menu = get_node_or_null("/root/Game/UI/Pause_menu")
		if pause_menu == null:
			get_tree().quit()
		else:
			if pause_menu.visible:
				pause_menu.hide()
				get_tree().paused = false
			else:
				pause_menu.show()
				get_tree().paused = true 

func _resize():
	VP = get_viewport().size
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()

func update_score(s):
	score += s 
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func update_lives(l):
	lives -= l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_lives()


func reset():
	score = 0
	time = 30
	lives = 5
