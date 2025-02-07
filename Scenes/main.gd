extends Control

signal gear_database_changed(gear_database)
signal display_ids(is_displaying)

var gear_database: GearDatabase

func _ready() -> void:
	
	DisplayServer.window_set_title("DK Hardware Manager - v0.1.0")
	gear_database = GearDatabase.load_save()
	gear_database_changed.emit(gear_database)
	ResourceSaver.save(gear_database, Utils.SAVE_PATH)
	
	get_node("Window/HBoxContainer2/Workspace/GearWorkspace").user_changed_database.connect(_on_user_changed_database)
	get_node("Window/HBoxContainer2/Workspace/GearWorkspace").need_save_to_file.connect(_on_need_save_to_file)
	
	get_node("Window/MenuBar/File").id_pressed.connect(_on_file_menu_pressed)
	get_node("Window/MenuBar/View").id_pressed.connect(_on_view_menu_pressed)
	
	get_node("Window/HBoxContainer2/VBoxContainer/DatabaseButton").pressed.connect(_on_database_button_pressed)
	get_node("Window/HBoxContainer2/VBoxContainer/ShootingButton").pressed.connect(_on_shooting_button_pressed)
	get_node("Window/HBoxContainer2/VBoxContainer/UserButton").pressed.connect(_on_user_button_pressed)

func save_frame():
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://Screenshot.png")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PrintDatabase"):
		print_database()
	if event.is_action_pressed("UpdateGraphics"):
		#gear_database_changed.emit(gear_database)
		get_node("Window/HBoxContainer2/Workspace/GearWorkspace").update_highlighted_row()

func _on_file_menu_pressed(id):
	match id:
		3:
			print("new database")
			gear_database.clear_database()
			gear_database_changed.emit(gear_database)
			get_node("Window/HBoxContainer2/Workspace/GearWorkspace").selected_row = -1
		_:
			print("Unknown menu ID in main._on_file_menu_pressed()")

func _on_view_menu_pressed(id):
	print("aisubdibasdibs ", id)
	match id:
		0:
			get_node("Window/MenuBar/View").set_item_checked(id, not get_node("Window/MenuBar/View").is_item_checked(id))
			display_ids.emit(get_node("Window/MenuBar/View").is_item_checked(id))
	pass

func save_to_file():
	ResourceSaver.save(gear_database, Utils.SAVE_PATH)

func _on_database_button_pressed():
	get_node("Window/HBoxContainer2/Workspace/GearWorkspace").set_visible(true)
	get_node("Window/HBoxContainer2/Workspace/ShootingWorkspace").set_visible(false)
	get_node("Window/HBoxContainer2/Workspace/UserWorkspace").set_visible(false)

func _on_shooting_button_pressed():
	get_node("Window/HBoxContainer2/Workspace/GearWorkspace").set_visible(false)
	get_node("Window/HBoxContainer2/Workspace/ShootingWorkspace").set_visible(true)
	get_node("Window/HBoxContainer2/Workspace/UserWorkspace").set_visible(false)

func _on_user_button_pressed():
	get_node("Window/HBoxContainer2/Workspace/GearWorkspace").set_visible(false)
	get_node("Window/HBoxContainer2/Workspace/ShootingWorkspace").set_visible(false)
	get_node("Window/HBoxContainer2/Workspace/UserWorkspace").set_visible(true)

func _on_need_save_to_file():
	save_to_file()

func _on_user_changed_database():
	gear_database_changed.emit(gear_database)

func print_database():
	print()
	print("Database :")
	for g in gear_database.gears:
		print("Gear id ", g.id)
