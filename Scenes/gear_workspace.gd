extends Control

signal user_changed_database
signal need_save_to_file

var gear_database: GearDatabase
@onready var header_grid: GridContainer = get_node("HBoxContainer2/VBoxContainer/GridContainer2")
@onready var database_grid: VBoxContainer = get_node("HBoxContainer2/VBoxContainer/ScrollContainer/GridContainer")
@onready var gear_form: GridContainer = get_node("HBoxContainer2/GearForm")
var selected_row: int = -1
var selected_gear_changed: bool = false: set = set_selected_gear_changed
var sorting_ascending: bool = true
var sorting_column_id: int = -1

# Display
var display_ids: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().get_parent().get_parent().get_parent().gear_database_changed.connect(_on_database_changed)
	get_parent().get_parent().get_parent().get_parent().display_ids.connect(_on_display_ids)
	get_node("NewGearButton").pressed.connect(_on_new_gear_button_pressed)
	connect_gear_form()
	
	#print(Utils.Department)
	#print(Utils.get_department_categories())
	
	build_department_dropdowns()
	build_user_dropdowns()

func _on_new_gear_button_pressed():
	print("Adding new gear ...")
	var new_gear: Gear = Gear.new()
	gear_database.add_new_gear(new_gear)
	user_changed_database.emit()
	#reload_database()
	#gear_database_changed.emit(gear_database)

func build_department_dropdowns():
	for e in Utils.Department.values():
		gear_form.get_node("LineEdit6").add_item(Utils.department_id_to_string(e))

func build_category_dropdowns(new_index):
	gear_form.get_node("LineEdit7").clear()
	for c in Utils.get_department_subcategories(new_index):
		gear_form.get_node("LineEdit7").add_item(c)

func build_user_dropdowns():
	for u in Utils.User.values():
		gear_form.get_node("LineEdit9").add_item(Utils.user_id_to_string(u))

func connect_gear_form():
	gear_form.get_node("LineEdit2").text_changed.connect(_on_line_edit_changed)
	gear_form.get_node("LineEdit3").text_changed.connect(_on_line_edit_changed)
	gear_form.get_node("LineEdit4").text_changed.connect(_on_line_edit_changed)
	gear_form.get_node("LineEdit5").text_changed.connect(_on_line_edit_changed)
	gear_form.get_node("LineEdit6").item_selected.connect(_on_department_menu_changed)
	gear_form.get_node("LineEdit7").item_selected.connect(_on_category_menu_changed)
	gear_form.get_node("LineEdit8").toggled.connect(_on_loading_changed)
	gear_form.get_node("LineEdit9").item_selected.connect(_on_user_menu_changed)
	gear_form.get_node("LineEdit10").text_changed.connect(_on_line_edit_changed)
	
	gear_form.get_node("Button").pressed.connect(_on_button_pressed)
	gear_form.get_node("Button2").pressed.connect(_on_button2_pressed)
	gear_form.get_node("Button3").pressed.connect(_on_button3_pressed)
	gear_form.get_node("Button4").pressed.connect(_on_button4_pressed)

func _on_display_ids(is_displaying):
	
	display_ids = is_displaying
	gear_form.get_node("LineEdit").visible = is_displaying
	gear_form.get_node("Label").visible = is_displaying
	
	for c in header_grid.get_children():
		if c.column_id == 0:
			c.visible = is_displaying
	
	for r in database_grid.get_children():
		for b in r.get_children():
			if b.column_id == 0:
				b.visible = is_displaying

func _on_line_edit_changed(_new_text):
	set_selected_gear_changed(true)

func _on_department_menu_changed(new_index):
	set_selected_gear_changed(true)
	build_category_dropdowns(new_index)

func _on_category_menu_changed(_new_index):
	set_selected_gear_changed(true)

func _on_user_menu_changed(_new_index):
	set_selected_gear_changed(true)

func _on_loading_changed(_new_state):
	set_selected_gear_changed(true)

func set_selected_gear_changed(new_selected):
	selected_gear_changed = new_selected
	if selected_gear_changed:
		gear_form.get_node("Button").modulate = Color(1,0,1)
	else:
		gear_form.get_node("Button").modulate = Color(1,1,1)

func _on_button_pressed():
	# Save current gear
	gear_database.gears[selected_row].brand = gear_form.get_node("LineEdit2").get_text()
	gear_database.gears[selected_row].model = gear_form.get_node("LineEdit3").get_text()
	gear_database.gears[selected_row].cost = int(gear_form.get_node("LineEdit4").get_text())
	gear_database.gears[selected_row].quantity = int(gear_form.get_node("LineEdit5").get_text())
	gear_database.gears[selected_row].department_id = gear_form.get_node("LineEdit6").selected
	gear_database.gears[selected_row].category_id = gear_form.get_node("LineEdit7").selected
	gear_database.gears[selected_row].need_loading = gear_form.get_node("LineEdit8").button_pressed
	#gear_database.gears[selected_row].user_id = gear_form.get_node("LineEdit9").selected
	gear_database.gears[selected_row].comment = gear_form.get_node("LineEdit10").get_text()
	user_changed_database.emit()
	need_save_to_file.emit()
	selected_gear_changed = false

func _on_button2_pressed(): # Template n°1
	print("Adding template gear n°1 ...")
	var new_gear: Gear = Gear.new()
	new_gear.brand = "Sony"
	new_gear.model = "a7S iii"
	new_gear.cost = 3500
	new_gear.quantity = 1
	new_gear.department_id = 0
	new_gear.category_id = 0
	new_gear.need_loading = true
	new_gear.comment = "10bits, 4K, 4:2:2"
	gear_database.add_new_gear(new_gear)
	user_changed_database.emit()
	need_save_to_file.emit()
	selected_gear_changed = false

func _on_button3_pressed(): # Template n°2
	print("Adding template gear n°2 ...")
	var new_gear: Gear = Gear.new()
	new_gear.brand = "Zoom"
	new_gear.model = "H5"
	new_gear.cost = 350
	new_gear.quantity = 1
	new_gear.department_id = 1
	new_gear.category_id = 0
	new_gear.need_loading = false
	new_gear.comment = ""
	gear_database.add_new_gear(new_gear)
	user_changed_database.emit()
	need_save_to_file.emit()
	selected_gear_changed = false

func _on_button4_pressed(): # Template n°3
	print("Adding template gear n°3 ...")
	var new_gear: Gear = Gear.new()
	new_gear.brand = "Tamron"
	new_gear.model = "28-75mm"
	new_gear.cost = 275
	new_gear.quantity = 1
	new_gear.department_id = 0
	new_gear.category_id = 1
	new_gear.need_loading = false
	new_gear.comment = "f/2.8-5.6"
	gear_database.add_new_gear(new_gear)
	user_changed_database.emit()
	need_save_to_file.emit()
	selected_gear_changed = false

func _on_line_edit_2_submitted(new_text): # Brand
	gear_database.gears[selected_row].brand = new_text
	user_changed_database.emit()
func _on_line_edit_3_submitted(new_text): # Model
	gear_database.gears[selected_row].model = new_text
	reload_database()
func _on_line_edit_4_submitted(new_text): # Cost
	gear_database.gears[selected_row].cost = int(new_text)
	reload_database()
func _on_line_edit_5_submitted(new_text): # Quantity
	gear_database.gears[selected_row].quantity = int(new_text)
	reload_database()
func _on_line_edit_6_submitted(_new_text): # Category
	#gear_database.gears[selected_row].category = new_text
	reload_database()
func _on_line_edit_7_submitted(_new_text): # Need loading
	gear_database.gears[selected_row].need_loading = true
	reload_database()
func _on_line_edit_8_submitted(_new_text): # User
	#gear_database.gears[selected_row].brand = new_text
	reload_database()
func _on_line_edit_9_submitted(new_text): # Comment
	gear_database.gears[selected_row].comment = new_text
	reload_database()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func reload_database():
	
	for c in header_grid.get_children():
		c.queue_free()
	
	for c in database_grid.get_children():
		c.queue_free()
	
	# ID
	add_header_grid_button("ID", -1, 0, 24)
		
	# Brand
	add_header_grid_button("Brand", -1, 1, 120)
	
	# Model
	add_header_grid_button("Model", -1, 2, 200)
	
	# Cost
	add_header_grid_button("Cost", -1, 3, 120)
	
	# Quantity
	add_header_grid_button("Qy", -1, 4, 24)
	
	# Category
	add_header_grid_button("Category", -1, 5, 120)
	
	# Need loading
	add_header_grid_button("Load", -1, 6, 48)
	
	# User
	#add_header_grid_button("User", -1, 7, 120)
	
	# Comment
	add_header_grid_button("Comment", -1, 8, 120)
	
	var row_id = 0
	for g: Gear in gear_database.gears:
		
		var row: HBoxContainer = HBoxContainer.new()
		database_grid.add_child(row)
		
		# ID
		add_grid_button(row, str(g.id), row_id, 0, 24)
		
		# Brand
		add_grid_button(row, g.brand, row_id, 1, 120)
		
		# Model
		add_grid_button(row, g.model, row_id, 2, 200)
		
		# Cost
		add_grid_button(row, str(g.cost), row_id, 3, 120)
		
		# Quantity
		add_grid_button(row, str(g.quantity) + "x", row_id, 4, 24)
		
		# Category
		#add_grid_button(row, Utils.category_id_to_string(g.category), row_id, 5, 120)
		add_grid_button(row, Utils.category_id_to_string(g.department_id,g.category_id, true), row_id, 5, 120)
		
		# Need loading
		var tmp_text = ""
		if g.need_loading:
			tmp_text = "☒"
		else:
			tmp_text = "☐"
		add_grid_button(row, tmp_text, row_id, 6, 48)
		
		# User
		#add_grid_button(row, Utils.user_id_to_string(g.user_id), row_id, 7, 120)
		
		# Comment
		add_grid_button(row, str(g.comment), row_id, 8, 120)
		
		if row_id == selected_row:
			row.modulate = Color(1,0.5,0)
		
		row_id += 1
	
	update_highlighted_row()

func add_header_grid_button(text: String, row_id: int, column_id: int, column_size: int):
	var new_button: GridButton = GridButton.new()
	new_button.set_text(text)
	new_button.set_row_id(row_id)
	new_button.set_column_id(column_id)
	new_button.set_column_size(column_size)
	header_grid.add_child(new_button)
	
	connect_header_buttons(new_button, column_id)
	
	if not display_ids and column_id == 0:
		new_button.visible = false

func connect_header_buttons(new_button: GridButton, column_id: int):
	#print("Column ID = ", column_id)
	if column_id in range(0, 10):
		new_button.pressed.connect(_on_header_pressed.bind(column_id))
	else:
		print("Unknown column ID in connect_header_buttons()")

func add_grid_button(row: HBoxContainer, text: String, row_id: int, column_id: int, column_size: int):
	var new_button: GridButton = GridButton.new()
	new_button.set_text(text)
	new_button.set_row_id(row_id)
	new_button.set_column_id(column_id)
	new_button.set_column_size(column_size)
	new_button.row_selected.connect(_on_row_selected)
	row.add_child(new_button)
	if not display_ids and column_id == 0:
		new_button.visible = false

func _on_header_pressed(column_id):
	print("Sorting by column ", column_id)
	if column_id == sorting_column_id:
		sorting_ascending = not sorting_ascending
		print("ascending")
	else:
		sorting_ascending = true
		print("descending")
	sorting_column_id = column_id
	gear_database.sort_gears(column_id, sorting_ascending)
	reload_database()
	
	for b in header_grid.get_children():
		if b.column_id == column_id:
			if sorting_ascending:
				b.text = "▼" + b.text
			else:
				b.text = "▲" + b.text

##### Signals #################################################################

func _on_row_selected(row_id):
	#for c in database_grid.get_children():
		#c.set_highlighted(false)
	#
	#for i in range(row_id*9, (row_id+1)*9):
		#database_grid.get_children()[i].set_highlighted(true)
	print("Row selected = ", row_id)
	selected_row = row_id
	update_gear_panel(row_id)
	selected_gear_changed = false
	update_highlighted_row()

func update_highlighted_row():
	if selected_row >= 0:
		for c in database_grid.get_children():
			c.modulate = Color(1,1,1)
		database_grid.get_children()[selected_row].modulate = Color(1,0.5,0)
		print("Row ", selected_row, " become orange")
	print("Selected row is ", selected_row)

func update_gear_panel(row_id):
	gear_form.get_node("LineEdit").set_text(str(gear_database.gears[row_id].id))
	gear_form.get_node("LineEdit2").set_text(gear_database.gears[row_id].brand)
	gear_form.get_node("LineEdit3").set_text(gear_database.gears[row_id].model)
	gear_form.get_node("LineEdit4").set_text(str(gear_database.gears[row_id].cost))
	gear_form.get_node("LineEdit5").set_text(str(gear_database.gears[row_id].quantity))
	#gear_form.get_node("LineEdit6").set_text(Utils.category_id_to_string(gear_database.gears[row_id].category))
	gear_form.get_node("LineEdit6").selected = gear_database.gears[row_id].department_id
	build_category_dropdowns(gear_database.gears[row_id].department_id)
	gear_form.get_node("LineEdit7").selected = gear_database.gears[row_id].category_id
	#gear_form.get_node("LineEdit7").set_text(Utils.category_id_to_string(gear_database.gears[row_id].department_id,gear_database.gears[row_id].category_id, false))
	#gear_form.get_node("LineEdit8").set_text(str(gear_database.gears[row_id].need_loading))
	gear_form.get_node("LineEdit8").button_pressed = gear_database.gears[row_id].need_loading
	#gear_form.get_node("LineEdit9").set_text(Utils.user_id_to_string(gear_database.gears[row_id].user_id))
	#gear_form.get_node("LineEdit9").selected = gear_database.gears[row_id].user_id
	gear_form.get_node("LineEdit10").set_text(gear_database.gears[row_id].comment)

func _on_database_changed(new_gear_database):
	print("Changement !")
	gear_database = new_gear_database
	reload_database()
